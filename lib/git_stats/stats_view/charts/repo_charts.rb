module GitStats
  module StatsView
    module Charts
      class RepoCharts
        def initialize(repo)
          @repo = repo
        end

        def files_by_extension
          Chart.new do |f|
            f.column_hash_chart(
                data: @repo.files_by_extension_count,
                title: :files_by_extension.t,
                y_text: :files.t
            )
          end
        end

        def lines_by_extension
          Chart.new do |f|
            f.column_hash_chart(
                data: @repo.lines_by_extension,
                title: :lines_by_extension.t,
                y_text: :lines.t
            )
          end
        end

        def files_by_date
          Chart.new do |f|
            f.date_chart(
                data: @repo.files_count_by_date,
                title: :files_by_date.t,
                y_text: :files.t
            )
          end
        end

        def lines_by_date
          Chart.new do |f|
            f.date_chart(
                data: @repo.lines_count_by_date,
                title: :lines_by_date.t,
                y_text: :lines.t
            )
          end
        end

        [:lines_added_by_author, :lines_deleted_by_author].each do |method|
          define_method method do
            Chart.new do |f|
              f.column_hash_chart(
                  data: Hash[@repo.send(method).map { |a, l| [a.email, l] }],
                  title: method.t,
                  y_text: :lines.t
              )
            end
          end
        end

      end
    end
  end
end
