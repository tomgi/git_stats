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
                title: "files_by_extension",
                y_text: "files"
            )
          end
        end

        def lines_by_extension
          Chart.new do |f|
            f.column_hash_chart(
                data: @repo.lines_by_extension,
                title: "lines_by_extension",
                y_text: "lines"
            )
          end
        end

        def files_by_date
          Chart.new do |f|
            f.day_chart(
                data: @repo.files_count_each_day,
                start_day: @repo.commits.first.date,
                title: "files_by_date",
                y_text: "files"
            )
          end
        end

        def lines_by_date
          Chart.new do |f|
            f.day_chart(
                data: @repo.lines_count_each_day,
                start_day: @repo.commits.first.date,
                title: "lines_by_date",
                y_text: "lines"
            )
          end
        end

      end
    end
  end
end
