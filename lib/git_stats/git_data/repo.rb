require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Repo
      include HashInitializable

      attr_reader :path, :git_command_observer

      def initialize(params)
        super(params)
        @path = File.expand_path(@path)
      end

      def authors
        @authors ||= run_and_parse('git shortlog -se HEAD').map do |author|
          Author.new(repo: self, name: author[:name], email: author[:email])
        end.extend(ByFieldFinder)
      end

      def commits
        @commits ||= run('git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').lines.map do |commit_line|
          hash, stamp, date, author_email = commit_line.split('|').map(&:strip)
          author = authors.by_email(author_email)

          date = DateTime.parse(date)
          Commit.new(repo: self, hash: hash, stamp: stamp, date: date, author: author)
        end.sort_by! { |e| e.date }
      end

      def commit_range
        @first_commit ? "#{@first_commit}..#{last_commit}" : last_commit
      end

      def last_commit
        @last_commit ||= 'HEAD'
      end

      def short_stats
        @short_stats ||= commits.map(&:short_stat)
      end

      def activity
        @activity ||= Activity.new(commits)
      end

      def project_version
        @project_version ||= run('git rev-parse --short HEAD')
      end

      def project_name
        @project_name ||= File.basename(path)
      end

      def run(command)
        in_repo_dir { CommandRunner.run(command) }
      end

      def run_and_parse(command)
        result = run(command)
        command_parser.parse(command, result)
      end

      def command_parser
        @command_parser ||= CommandParser.new
      end

      def in_repo_dir
        Dir.chdir(path) { yield }
      end

      def to_s
        "#{self.class} #@path"
      end

      def ==(other)
        self.path == other.path
      end

    end
  end
end