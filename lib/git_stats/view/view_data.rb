class GitStats::ViewData
  include ActionView::Helpers::TagHelper
  include LazyHighCharts::LayoutHelper

  attr_accessor :git_data

  def initialize(git_data)
    self.git_data = git_data
    generate_charts
  end

  def generate_charts
    @h = LazyHighCharts::HighChart.new('graph') do |f|
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
      git_data.authors.each do |email, author|
        f.series(:name => email, :data => author.activity.by_wday.inject([]) { |acc, (k, v)| acc[k] = v; acc })
      end
    end
  end
end