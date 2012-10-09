class GitStats::Generator
  def initialize(repo_path, out_path)
    @repo_path, @out_path = repo_path, out_path
  end

  def generate
    data = GitStats::GitData.new(@repo_path)
    view_data = GitStats::ViewData.new(data)
    GitStats::View.render_all(view_data, @out_path)
  end
end
