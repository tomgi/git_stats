module GitStats
  module StatsView
    class ViewData
      include ActionView::Helpers::TagHelper
      include LazyHighCharts::LayoutHelper

      attr_reader :repo

      def initialize(repo)
        @repo = repo
      end

      def h
        @h ||= LazyHighCharts::HighChart.new('graph') do |f|
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
            f.series(:name => email, :data => author.activity.by_wday.inject([]) { |acc, (k, v)| acc[k] = v; acc })
          end
        end
      end
    end
  end
end