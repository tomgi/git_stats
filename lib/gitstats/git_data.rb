class GitStats::GitData
  attr_reader :total_authors
  attr_reader :total_commits

  def initialize(repo_path)
    @repo_path = repo_path
  end

  def gather_all_data
    Dir.chdir(@repo_path) {
      @total_authors = %x[git shortlog -s HEAD | wc -l]
    }
  end
end
