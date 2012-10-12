module GitStats
  module GitData
    class Activity

      attr_reader :by_hour, :by_wday, :by_wday_hour, :by_month, :by_year, :by_year_week

      def initialize(commits)
        @by_hour = @by_wday = @by_month = @by_year = Hash.new(0)
        @by_wday_hour = @by_year_week = Hash.new { |h, k| h[k] = Hash.new(0) }

        add_commits(commits)
      end

      private
      def add_commits(commits)
        commits.values.each do |commit|
          add_commit_at(commit.date)
        end
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