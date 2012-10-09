class GitStats::Generator
  def initialize(repo_path, out_path)
    @repo_path, @out_path = repo_path, out_path
  end

  def generate
    repo = GitStats::GitRepo.new(@repo_path)
    data = GitStats::GitData.new(repo)
    data.gather_all

    view_data = GitStats::ViewData.new(data)
    view_data.generate_charts

    GitStats::View.render_all(view_data, @out_path)
  end
end
