module GitStats
  module StatsView
    module Charts
      class ActivityCharts
        def initialize(activity)
          @activity = activity
        end

        def activity_by_hour
          Chart.new do |f|
            f.simple_column_chart(
                title: :commits_by_hour.t,
                y_text: :commits.t,
                x_text: :hour.t,
                data_x: (0..23),
                data_y: @activity.by_hour_array
            )
          end
        end

        def activity_by_wday
          Chart.new do |f|
            f.simple_column_chart(
                title: :commits_by_wday.t,
                y_text: :commits.t,
                x_text: :day.t,
                data_x: Date::ABBR_DAYNAMES,
                data_y: @activity.by_wday_array
            )
          end
        end

        def activity_by_month
          Chart.new do |f|
            f.simple_column_chart(
                title: :commits_by_month.t,
                y_text: :commits.t,
                x_text: :month.t,
                data_x: Date::ABBR_MONTHNAMES[1..-1],
                data_y: @activity.by_month_array
            )
          end
        end
      end
    end
  end
end
