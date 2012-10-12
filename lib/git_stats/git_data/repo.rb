module GitStats
  module GitData
    class Repo
      attr_reader :path

      def initialize(path)
        @path = path
      end

      def authors
        @authors ||= Command.new(self, 'git shortlog -se HEAD').run.lines.inject({}) do |authors, line|
          name, email = line.split(/\t/)[1].strip.scan(/(.*)<(.*)>/).first.map(&:strip)
          authors[email] = Author.new(repo: self, name: name, email: email)
          authors
        end
      end

      def commits
        @commits ||= Command.new(self, 'git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').run.lines.inject({}) do |commits, commit_line|
          hash, stamp, date, author_email = commit_line.split('|').map(&:strip)
          author = authors[author_email]

          date = DateTime.parse(date)
          commits[hash] = Commit.new(repo: self, hash: hash, stamp: stamp, date: date, author: author)
          commits
        end
      end

      def activity
        @activity ||= commits.values.inject(Activity.new) do |activity, commit|
          activity.add_commit(commit)
          activity
        end
      end

      def project_version
        @project_version ||= Command.new(self, 'git rev-parse --short HEAD').run
      end

      def project_name
        @project_name ||= Pathname(path).basename.to_s
      end

    end
  end
end