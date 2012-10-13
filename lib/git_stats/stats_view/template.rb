module GitStats
  module StatsView
    class Template
      def initialize(name, layout)
        @name = name
        @layout = layout
        @template = Tilt.new("templates/#@name.haml")
      end

      def render(data, all_templates)
        @layout.render(data, :active_page => @name, :all_templates => all_templates) { @template.render(data) }
      end
    end
  end
end