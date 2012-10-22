module GitStats
  module StatsView
    class View
      def initialize(view_data, out_path)
        @view_data, @out_path = view_data, out_path
        @layout = Tilt.new("templates/layout.haml")
      end

      def render_all
        prepare_static_content
        prepare_assets

        all_templates.each do |template|
          output = Template.new(template, @layout).render(@view_data, author: @view_data.repo, links: links)
          write(output, "#@out_path/#{template}.html")
        end

        render_authors_activity
      end

      def render_authors_activity
        done = []
        @view_data.repo.authors.sort_by { |a| -a.commits.size }.each do |author|
          next if done.include? author.dirname
          done << author.dirname
          all_templates('activity/').each do |template|
            output = Template.new(template, @layout).render(@view_data,
                                                            author: author,
                                                            links: links,
                                                            active_page: "/authors/#{author.dirname}/#{template}")
            write(output, "#@out_path/authors/#{author.dirname}/#{template}.html")
          end
        end
      end

      def all_templates(root = '')
        Dir["templates/#{root}**/[^_]*.haml"].map {
            |f| Pathname.new(f)
        }.map { |f|
          f.relative_path_from(Pathname.new('templates')).sub_ext('')
        }.map(&:to_s) - %w(layout)
      end

      private

      def write(output, write_file)
        FileUtils.mkdir_p(File.dirname(write_file))
        File.open(write_file, 'w') { |f| f.write output }
      end

      def links
        {
            'General' => 'general.html',
            'Activity' => 'activity/by_date.html',
            'Authors' => 'authors/best_authors.html',
            'Files' => 'files/by_date.html',
            'Lines' => 'lines/by_date.html'
        }
      end

      def prepare_static_content
        FileUtils.cp_r(Dir['templates/static/*'], @out_path)
      end

      def prepare_assets
        FileUtils.cp_r('templates/assets', @out_path)
      end

    end
  end
end