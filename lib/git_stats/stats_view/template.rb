module GitStats
  module StatsView
    class Template
      def initialize(name, layout=nil)
        @name = name
        @layout = layout
        @template = Tilt.new("templates/#@name.haml")
      end

      def render(data, params={})
        if @layout
          @layout.render(data, :active_page => params[:active_page] || @name, :links => params[:links]) { @template.render(data, params) }
        else
          @template.render(data, params)
        end
      end
    end
  end
end