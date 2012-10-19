module GitStats
  module StatsView
    module Charts
      class Chart

        def method_missing(name, *args, &block)
          @chart.send(name, *args, &block)
        end

        def initialize
          @chart = LazyHighCharts::HighChart.new('graph')
          yield self if block_given?
        end

        def type(type)
          @chart.chart(type: type)
        end

        def x_categories(categories)
          @chart.xAxis(categories: categories)
        end

        def y_text(text)
          @chart.yAxis(min: 0, title: {text: text})
        end

        def title(title)
          @chart.title(text: title)
        end

        def default_legend
          legend(
              layout: 'vertical',
              backgroundColor: '#FFFFFF',
              align: 'left',
              verticalAlign: 'top',
              x: 100,
              y: 70,
              floating: true,
              shadow: true
          )
        end
      end
    end
  end
end
