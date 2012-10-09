module GitStats
  module GitData
    class Repo
      attr_reader :path

      def initialize(path)
        @path = path
      end

      def gather_all_data
        project_version
        project_name
        gather_authors
        gather_commits
      end

      def gather_authors
        Command.new(self, 'git shortlog -se HEAD').run.each_line do |author|
          name, email = author.split(/\t/)[1].strip.scan(/(.*)<(.*)>/).first.map(&:strip)
          authors[email] = Author.new(name: name, email: email)
        end
      end

      def gather_commits
        Command.new(self, 'git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').run.lines.each_with_index do |commit_line, i|
          hash, stamp, date, author_email = commit_line.split('|').map(&:strip)
          author = authors[author_email]

          date = DateTime.parse(date)
          commit = commits[hash] = Commit.new(repo: self, hash: hash, stamp: stamp, date: date, author: author)
          commit.gather_all_data

          activity.add_commit(commit)
          author.add_commit(commit)
        end
      end

      def authors
        @authors ||= {}
      end

      def commits
        @commits ||= {}
      end

      def activity
        @activity ||= Activity.new
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