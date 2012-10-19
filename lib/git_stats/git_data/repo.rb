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
        @authors ||= Command.new(self, 'git shortlog -se HEAD').run_and_parse.inject({}) do |hash, author|
          hash[author[:email]] = Author.new(repo: self, name: author[:name], email: author[:email])
          hash
        end
      end

      def commits
        @commits ||= Command.new(self, 'git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').run.lines.map do |commit_line|
          hash, stamp, date, author_email = commit_line.split('|').map(&:strip)
          author = authors[author_email]

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
        @project_version ||= Command.new(self, 'git rev-parse --short HEAD').run
      end

      def project_name
        @project_name ||= File.basename(path)
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