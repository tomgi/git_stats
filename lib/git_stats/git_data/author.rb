require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Author
      include HashInitializable

      attr_reader :repo, :name, :email

      def commits
        @commits ||= repo.commits.select { |commit| commit.author == self }
      end

      def commits_sum_by_date
        sum = 0
        commits.map { |commit|
          sum += 1
          [commit.date, sum]
        }
      end

      [:insertions, :deletions].each do |method|
        define_method method do
          short_stats.map { |s| s.send(method)} .sum
        end

        define_method "#{method}_by_date" do
          sum = 0
          commits.map { |commit|
            sum += commit.short_stat.send(method)
            [commit.date, sum]
          }
        end
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