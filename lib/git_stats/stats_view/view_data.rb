module GitStats
  module StatsView
    class ViewData
      include ActionView::Helpers::TagHelper
      include LazyHighCharts::LayoutHelper

      attr_reader :repo

      def initialize(repo)
        @repo = repo
      end

      def by_wday
        @by_wday ||= LazyHighCharts::HighChart.new('graph') do |f|
          f.chart(type: "column")
          f.title(text: "Commits")
          f.xAxis(categories: Date::ABBR_DAYNAMES)
          f.yAxis(min: 0, title: {text: 'Commits'})
          f.legend(
              layout: 'vertical',
              backgroundColor: '#FFFFFF',
              align: 'left',
              verticalAlign: 'top',
              x: 100,
              y: 70,
              floating: true,
              shadow: true
          )
          repo.authors.each do |email, author|
            f.series(name: email, data: author.activity.by_wday.inject([]) { |acc, (k, v)| acc[k] = v; acc })
          end
        end
      end

      def files_by_date
        @files_by_date ||= LazyHighCharts::HighChart.new('graph') do |f|
          f.title(text: "Files")
          f.xAxis(type: "datetime")
          f.yAxis(min: 0, title: {text: 'Commits'})
          rcommits = repo.commits.reverse
          f.series(
              type: "area",
              name: "commits",
              pointInterval: 1.day * 1000,
              pointStart: repo.commits.first.date.to_i * 1000,
              data: repo.commits.first.date.midnight.upto((repo.commits.last.date + 1.day).midnight).map { |day|
                rcommits.find { |c| c.date < day }.files_count rescue 0
              }
          )
        end
      end
    end
  end
end