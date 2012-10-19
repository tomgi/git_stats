module GitStats
  module StatsView
    module Charts
      class RepoCharts
        def initialize(repo)
          @repo = repo
        end

        def files_by_extension
          Chart.new do |f|
            f.type "column"
            f.title "files by extension"
            f.x_categories @repo.files_by_extension_count.keys
            f.y_text 'Commits'
            f.series(name: "commits", data: @repo.files_by_extension_count.values)
          end
        end

        def lines_by_extension
          Chart.new do |f|
            f.type "column"
            f.title "lines by extension"
            f.x_categories @repo.lines_by_extension.keys
            f.y_text 'Commits'
            f.series(name: "commits", data: @repo.lines_by_extension.values)
          end
        end

        def files_by_date
          Chart.new do |f|
            f.title "Files"
            f.type "datetime"
            f.y_text 'Commits'
            f.series(
                type: "area",
                name: "commits",
                pointInterval: 1.day * 1000,
                pointStart: @repo.commits.first.date.to_i * 1000,
                data: @repo.files_count_each_day
            )
          end
        end

        def lines_by_date
          Chart.new do |f|
            f.title "Files"
            f.type "datetime"
            f.y_text 'Commits'
            f.series(
                type: "area",
                name: "commits",
                pointInterval: 1.day * 1000,
                pointStart: @repo.commits.first.date.to_i * 1000,
                data: @repo.lines_count_each_day
            )
          end
        end

      end
    end
  end
end
