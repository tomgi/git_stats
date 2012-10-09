module GitStats
  module StatsView
    class View
      def self.render_all(data, out_path)
        prepare_assets(out_path)

        layout = Tilt.new("templates/layout.haml")
        output = Template.new('index', layout).render(data)
        File.open("#{out_path}/index.html", 'w') { |f| f.write output }
      end

      def self.prepare_assets(out_path)
        FileUtils.cp_r('templates/assets', out_path)
      end
    end
  end
end