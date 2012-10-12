module GitStats
  module GitData
    class Activity

      def initialize(commits)
        commits.values.each do |commit|
          add_commit(commit)
        end
      end

      def by_hour
        @by_hour ||= Hash.new(0)
      end

      def by_wday
        @by_wday ||= Hash.new(0)
      end

      def by_wday_hour
        @by_wday_hour ||= Hash.new { |h, k| h[k] = Hash.new(0) }
      end

      def by_month
        @by_month ||= Hash.new(0)
      end

      def by_year
        @by_year ||= Hash.new(0)
      end

      def by_year_week
        @by_year_week ||= Hash.new { |h, k| h[k] = Hash.new(0) }
      end

      private
      def add_commit(commit)
        add_commit_at(commit.date)
      end

      def add_commit_at(date)
        self.by_hour[date.hour] += 1
        self.by_wday[date.wday] += 1
        self.by_wday_hour[date.wday][date.hour] += 1
        self.by_month[date.month] += 1
        self.by_year[date.year] += 1
        self.by_year_week[date.year][date.cweek] += 1
      end

    end
  end
end