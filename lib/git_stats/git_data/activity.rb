module GitStats
  module GitData
    class Activity

      def initialize(commits)
        add_commits(commits)
      end

      def by_hour
        @by_hour ||= default_hash
      end

      def by_hour_array
        by_hour.to_key_indexed_array(min_size: 24, default: 0)
      end

      def by_wday
        @by_wday ||= default_hash
      end

      def by_wday_array
        by_wday.to_key_indexed_array(min_size: 7, default: 0)
      end

      def by_wday_hour
        @by_wday_hour ||= default_double_hash
      end

      def by_month
        @by_month ||= default_hash
      end

      def by_month_array
        by_month.to_key_indexed_array(min_size: 13, default: 0)[1..-1]
      end

      def by_year
        @by_year ||= default_hash
      end

      def by_year_month
        @by_year_week ||= default_double_hash
      end

      private
      def add_commits(commits)
        commits = commits.values if commits.is_a? Hash
        commits.each do |commit|
          add_commit_at(commit.date)
        end
      end

      def add_commit_at(date)
        self.by_hour[date.hour] += 1
        self.by_wday[date.wday] += 1
        self.by_wday_hour[date.wday][date.hour] += 1
        self.by_month[date.month] += 1
        self.by_year[date.year] += 1
        self.by_year_month[date.year][date.month] += 1
      end

      def default_hash
        Hash.new(0)
      end

      def default_double_hash
        Hash.new { |h, k| h[k] = Hash.new(0) }
      end

    end
  end
end