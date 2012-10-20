module GitStats
  module StatsView
    module Charts
      class AuthorsCharts
        def initialize(authors)
          @authors = authors
        end

        def by_authors_wday
          Chart.new do |f|
            f.multiple_column_chart(
                title: :by_authors_wday.t,
                y_text: :commits.t,
                data_x: Date::ABBR_DAYNAMES,
                data_y: @authors.map { |author| {name: author.email, data: author.activity.by_wday.to_key_indexed_array} }
            )
            f.default_legend
          end
        end
      end
    end
  end
end
