module GitStats
  class Generator
    def initialize(repo_path, out_path)
      @repo_path, @out_path = repo_path, out_path
    end

    def generate
      validate_paths

      repo = GitData::Repo.new(@repo_path)
      view_data = StatsView::ViewData.new(repo)

      StatsView::View.render_all(view_data, @out_path)
    end

    private
    def validate_paths
      validate_repo_path
      validate_out_path
    end

    def validate_repo_path
      raise ArgumentError, "#@repo_path is not a git repository" unless Dir.exists?("#@repo_path/.git")
    end

    def validate_out_path
      raise ArgumentError, "#@out_path is not a directory" unless Dir.exists?(@out_path)
    end
  end

end