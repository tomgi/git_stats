module GitStats
  module StatsView
    module Charts
      class ActivityCharts
        def initialize(activity)
          @activity = activity
        end

        def activity_by_hour
          Chart.new do |f|
            f.type "column"
            f.title "Commits"
            f.x_categories (0..23)
            f.y_text 'Commits'
            f.series(name: "commits", data: @activity.by_hour.to_key_indexed_array)
          end
        end
      end
    end
  end
end
