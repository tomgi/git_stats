require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Repo
      include HashInitializable

      attr_reader :path

      delegate :files, :files_by_extension, :files_by_extension_count, :lines_by_extension, :files_count, :lines_count, to: :last_commit

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
              hash: commit_line[:hash],
              stamp: commit_line[:stamp],
              date: DateTime.parse(commit_line[:date]),
              author: authors.by_email(commit_line[:author_email])
          )
        end.sort_by! { |e| e.date }.extend(ByFieldFinder)
      end

      def last_commit
        commits.last
      end

      def commit_range
        @first_commit_hash ? "#@first_commit_hash..#{last_commit_hash}" : last_commit_hash
      end

      def last_commit_hash
        @last_commit_hash ||= 'HEAD'
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