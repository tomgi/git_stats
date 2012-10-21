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

        def simple_column_chart(params)
          column_chart(params)
          series(name: params[:title], data: params[:data_y])
        end

        def multiple_column_chart(params)
          column_chart(params)
          params[:data_y].each do |s|
            series(name: s[:name], data: s[:data])
          end
        end

        def column_hash_chart(params)
          simple_column_chart(params.merge(
                                  data_x: params[:data].keys,
                                  data_y: params[:data].values
                              )
          )
        end

        def date_chart(params)
          common_options(params)
          rangeSelector(selected: 1)
          series(
              name: params[:title],
              type: "spline",
              data: params[:data].map { |date, value| [date.to_i * 1000, value] }
          )
        end

        def date_column_chart(params)
          date_chart(params)
          data[0][:type] = 'column'
          data[0][:dataGrouping] = {units: [['week', [1]]], forced: true}
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

        def no_legend
          legend(
              enabled: false
          )
        end

        def type(type)
          @chart.chart!(type: type)
        end

        def x_categories(categories)
          @chart.xAxis!(categories: categories)
        end

        def x_text(text)
          @chart.xAxis!(title: {text: text})
        end

        def y_text(text)
          @chart.yAxis!(title: {text: text})
        end

        def title(title)
          @chart.title!(text: title)
        end

        private
        def common_options(params)
          no_legend
          title ""
          y_text params[:y_text]
          x_text params[:x_text]
        end

        def column_chart(params)
          common_options(params)
          type "column"
          x_categories params[:data_x]
        end
      end
    end
  end
end
