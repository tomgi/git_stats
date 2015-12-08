# -*- encoding : utf-8 -*-
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

        def files_by_extension_by_date
          Chart.new do |f|
            f.multi_date_chart(
                data: @repo.files_by_extension_by_date,
                title: :files_by_extension_by_date.t,
                y_text: :files.t
            )
          end
        end

        def lines_by_extension_by_date
          Chart.new do |f|
            f.multi_date_chart(
                data: @repo.lines_by_extension_by_date,
                title: :lines_by_extension_by_date.t,
                y_text: :files.t
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

        def comments_by_date
          Chart.new do |f|
            f.date_chart(
                data: @repo.comments_count_by_date,
                title: :comments_by_date.t,
                y_text: :comments.t
            )
          end
        end

      end
    end
  end
end
