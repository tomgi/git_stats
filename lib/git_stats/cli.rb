require "git_stats"

class GitStats::CLI

  def start(*args)
    raise "Wrong number of arguments\nUsage: git_stats repo_path output_path" unless args.size == 2

    repo_path, out_path = args
    GitStats::Generator.new(repo_path, out_path).generate
  end

end
