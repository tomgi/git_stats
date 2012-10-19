module GitStats
  module StatsView
    module Charts
      class AuthorsCharts
        def initialize(authors)
          @authors = authors
        end

        def by_authors_wday
          Chart.new do |c|
            c.type "column"
            c.title 'by_wday_authors'
            c.x_categories Date::ABBR_DAYNAMES
            c.y_text 'y_text'
            c.default_legend

            @authors.each do |author|
              c.series(name: author.email, data: author.activity.by_wday.to_key_indexed_array)
            end
          end
        end
      end
    end
  end
end
