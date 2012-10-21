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

        [:insertions, :deletions, :changed_lines].each do |method|
          define_method "#{method}_by_author_by_date" do |limit = 4|
            Chart.new do |f|
              f.multi_date_chart(
                  data: @authors.sort_by { |author| -author.send(method) }[0..limit].map { |author| {name: author.email, data: author.send("#{method}_by_date")} },
                  title: :lines_by_date.t,
                  y_text: :lines.t
              )
            end
          end
        end

      end
    end
  end
end
