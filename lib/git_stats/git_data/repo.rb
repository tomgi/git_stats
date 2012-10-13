module GitStats
  module GitData
    class Repo
      attr_reader :path

      def initialize(path)
        @path = File.expand_path(path)
      end

      def authors
        @authors ||= Hash[Command.new(self, 'git shortlog -se HEAD').run.lines.map do |line|
          name, email = line.split(/\t/)[1].strip.scan(/(.*)<(.*)>/).first.map(&:strip)
          [email, Author.new(repo: self, name: name, email: email)]
        end]
      end

      def commits
        @commits ||= Command.new(self, 'git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').run.lines.map do |commit_line|
          hash, stamp, date, author_email = commit_line.split('|').map(&:strip)
          author = authors[author_email]

          date = DateTime.parse(date)
          Commit.new(repo: self, hash: hash, stamp: stamp, date: date, author: author)
        end.sort_by! { |e| e.date }
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