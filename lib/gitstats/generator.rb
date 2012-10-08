class GitStats::Generator
  def initialize(repo_path, out_path)
    @repo_path, @out_path = repo_path, out_path
  end

  def generate
    puts "generating..."
  end
end
