require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Author
      include HashInitializable

      attr_reader :repo, :name, :email

      def commits
        @commits ||= repo.commits.select { |commit| commit.author == self }
      end

      def lines_added
        short_stats.map(&:insertions).sum
      end

      def lines_deleted
        short_stats.map(&:deletions).sum
      end

      def short_stats
        commits.map(&:short_stat)
      end

      def activity
        @activity ||= Activity.new(commits)
      end

      def to_s
        "#{self.class} #@name <#@email>"
      end

      def ==(other)
        [self.repo, self.name, self.email] == [other.repo, other.name, other.email]
      end

    end
  end
end