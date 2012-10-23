# -*- encoding : utf-8 -*-
module GitStats
  module StatsView
    module Charts
      class ActivityCharts
        def initialize(repo)
          @repo = repo
          @activity = repo.activity
        end

        def activity_by_date(author)
          Chart.new do |f|
            f.date_column_chart(
                data: author.activity.by_date,
                title: :commits_by_date.t,
                y_text: :commits.t
            )
          end
        end

        def activity_by_hour(author)
          Chart.new do |f|
            f.simple_column_chart(
                title: :commits_by_hour.t,
                y_text: :commits.t,
                x_text: :hour.t,
                data_x: (0..23),
                data_y: author.activity.by_hour_array
            )
          end
        end

        def activity_by_wday(author)
          Chart.new do |f|
            f.simple_column_chart(
                title: :commits_by_wday.t,
                y_text: :commits.t,
                x_text: :day.t,
                data_x: I18n.t('date.abbr_day_names'),
                data_y: author.activity.by_wday_array
            )
          end
        end

        def activity_by_month(author)
          Chart.new do |f|
            f.simple_column_chart(
                title: :commits_by_month.t,
                y_text: :commits.t,
                x_text: :month.t,
                data_x: I18n.t('date.abbr_month_names')[1..-1],
                data_y: author.activity.by_month_array
            )
          end
        end

        def activity_by_year(author)
          Chart.new do |f|
            f.column_hash_chart(
                title: :commits_by_year.t,
                y_text: :commits.t,
                x_text: :year.t,
                data: author.activity.by_year
            )
          end
        end
      end
    end
  end
end
