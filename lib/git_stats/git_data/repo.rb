require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Repo
      include HashInitializable

      attr_reader :path

      delegate :files, :files_by_extension, :files_by_extension_count, :lines_by_extension_count,
               :files_count, :binary_files, :text_files, :lines_count, to: :last_commit

      def initialize(params)
        super(params)
        @path = File.expand_path(@path)
      end

      def authors
        @authors ||= run_and_parse("git shortlog -se #{commit_range}").map do |author|
          Author.new(repo: self, name: author[:name], email: author[:email])
        end.extend(ByFieldFinder)
      end

      def commits
        @commits ||= run_and_parse("git rev-list --pretty=format:'%h|%at|%ai|%aE' #{commit_range} | grep -v commit").map do |commit_line|
          Commit.new(
              repo: self,
              sha: commit_line[:sha],
              stamp: commit_line[:stamp],
              date: DateTime.parse(commit_line[:date]),
              author: authors.by_email(commit_line[:author_email])
          )
        end.sort_by! { |e| e.date }.extend(ByFieldFinder)
      end

      def commits_period
        commits.map(&:date).minmax
      end

      def commits_count_by_author(limit = 4)
        Hash[authors.map { |author| [author, author.commits.size] }.sort_by { |author, commits| -commits }[0..limit]]
      end

      [:insertions, :deletions].each do |method|
        define_method "#{method}_by_author" do |limit = 4|
          Hash[authors.map { |author| [author, author.send(method)] }.sort_by { |author, lines| -lines }[0..limit]]
        end
      end

      def files_count_by_date
        @files_count_each_day ||= Hash[commits.map { |commit|
          [commit.date, commit.files_count]
        }]
      end

      def lines_count_by_date
        sum = 0
        Hash[commits.map { |commit|
          sum += commit.short_stat.insertions
          sum -= commit.short_stat.deletions
          [commit.date, sum]
        }]
      end

      def last_commit
        commits.last
      end

      def commit_range
        @first_commit_sha ? "#@first_commit_sha..#{last_commit_sha}" : last_commit_sha
      end

      def last_commit_sha
        @last_commit_sha ||= 'HEAD'
      end

      def short_stats
        @short_stats ||= commits.map(&:short_stat)
      end

      def activity
        @activity ||= Activity.new(commits)
      end

      def project_version
        @project_version ||= run("git rev-parse --short #{commit_range}").strip
      end

      def project_name
        @project_name ||= File.basename(path)
      end

      def run(command)
        result = command_runner.run(path, command)
        invoke_command_observers(command, result)
        result
      end

      def run_and_parse(command)
        result = run(command)
        command_parser.parse(command, result)
      end

      def command_runner
        @command_runner ||= CommandRunner.new
      end

      def command_parser
        @command_parser ||= CommandParser.new
      end

      def add_command_observer(proc=nil, &block)
        command_observers << block if block_given?
        command_observers << proc if proc
      end

      def to_s
        "#{self.class} #@path"
      end

      def ==(other)
        self.path == other.path
      end

      private
      def command_observers
        @command_observers ||= []
      end

      def invoke_command_observers(command, result)
        command_observers.each { |o| o.call(command, result) }
      end

    end
  end
end