# -*- encoding : utf-8 -*-
require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Author
      include HashInitializable

      attr_reader :repo, :name

      def commits
        @commits ||= repo.commits.select { |commit| commit.author == self }
      end

      def changed_lines
        insertions + deletions
      end

      def insertions
        short_stats.map(&:insertions).sum
      end

      def deletions
        short_stats.map(&:deletions).sum
      end

      def commits_sum_by_date
        sum = 0
        commits.map { |commit|
          sum += 1
          [commit.date, sum]
        }
      end

      [:insertions, :deletions, :changed_lines].each do |method|
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

      def dirname
        @name.underscore.split.join '_'
      end

      def to_s
        "#{self.class} #@name"
      end

      def ==(other)
        self.name == other.name
      end

    end
  end
end
