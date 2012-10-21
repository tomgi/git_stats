module GitStats
  module StatsView
    module Charts
      class AuthorsCharts
        def initialize(authors)
          @authors = authors
        end

        def commits_sum_by_author_by_date(limit = 4)
          Chart.new do |f|
            f.multi_date_chart(
                data: @authors.sort_by { |author| -author.commits.size }[0..limit].map { |author| {name: author.email, data: author.commits_sum_by_date} },
                title: :lines_by_date.t,
                y_text: :lines.t
            )
          end
        end

        def lines_added_by_author_by_date(limit = 4)
          Chart.new do |f|
            f.multi_date_chart(
                data: @authors.sort_by { |author| -author.lines_added }[0..limit].map { |author| {name: author.email, data: author.insertions_by_date} },
                title: :lines_by_date.t,
                y_text: :lines.t
            )
          end
        end

        def lines_deleted_by_author_by_date(limit = 4)
          Chart.new do |f|
            f.multi_date_chart(
                data: @authors.sort_by { |author| -author.lines_deleted }[0..limit].map { |author| {name: author.email, data: author.deletions_by_date} },
                title: :lines_by_date.t,
                y_text: :lines.t
            )
          end
        end

      end
    end
  end
end
