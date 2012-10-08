require 'git_stats/git_data/git_data'
require 'git_stats/template/assets'
require 'git_stats/template/template'

class GitStats::Generator
  def initialize(repo_path, out_path)
    @repo_path, @out_path = repo_path, out_path
  end

  def generate
    data = GitStats::GitData.new(@repo_path)
    data.gather_all_data
    GitStats::Assets.prepare(@out_path)
    output = GitStats::Template.new('index').render(data)
    File.open("#@out_path/index.html", 'w') { |f| f.write output }
  end
end
