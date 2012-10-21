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

      def render(template_name, params = {})
        Template.new(template_name).render(self, params)
      end

    end
  end
end