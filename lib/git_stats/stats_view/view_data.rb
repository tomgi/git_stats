module GitStats
  module StatsView
    class ViewData
      include ActionView::Helpers::TagHelper
      include LazyHighCharts::LayoutHelper
      attr_reader :repo

      def initialize(repo)
        @repo = repo
      end

      def charts
        @charts ||= Charts::All.new(repo)
      end

      def render_partial(template_name, params = {})
        Template.new(template_name).render(self, params)
      end

      def asset_path(asset, active_page)
        Pathname.new("/assets/#{asset}").relative_path_from(Pathname.new("/#{active_page}").dirname)
      end

      def link_to(href, active_page)
        Pathname.new("/#{href}").relative_path_from(Pathname.new("/#{active_page}").dirname)
      end

    end
  end
end