module GitStats
  class Generator
    def initialize(repo_path, out_path)
      @repo_path, @out_path = repo_path, out_path
    end

    def generate
      repo = GitData::Repo.new(@repo_path)
      repo.gather_all_data

      view_data = StatsView::ViewData.new(repo)
      view_data.generate_charts

      StatsView::View.render_all(view_data, @out_path)
    end
  end

end