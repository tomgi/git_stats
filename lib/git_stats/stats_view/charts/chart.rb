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

        def column_hash_chart(params)
          common_params(params)
          type "column"
          x_categories params[:data].keys
          series(name: params[:title], data: params[:data].values)
        end

        def day_chart(params)
          common_params(params)
          type "datetime"
          series(
              type: "area",
              name: "commits",
              pointInterval: 1.day * 1000,
              pointStart: params[:start_day].to_i * 1000,
              data: params[:data]
          )
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

        private
        def common_params(params)
          title params[:title]
          y_text params[:y_text]
        end

      end
    end
  end
end
