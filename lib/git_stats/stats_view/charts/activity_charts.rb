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
                data_x: (0..23),
                data_y: @activity.by_hour.to_key_indexed_array
            )
          end
        end
      end
    end
  end
end
