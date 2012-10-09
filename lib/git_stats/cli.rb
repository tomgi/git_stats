require "git_stats"

class GitStats::CLI

  def self.start(*args)
    if args.size == 2
      repo_path, out_path = args
      validate(repo_path, out_path)
      GitStats::Generator.new(repo_path, out_path).generate
      #Launchy.open("#{out_path}/index.html")
    else
      puts "Wrong number of arguments"
      help
    end
  end

  private
  def self.help
    puts "Usage: git_stats repo_path output_path"
    exit 0
  end

  def self.validate(repo_path, out_path)
    validate_repo(repo_path)
    validate_out(out_path)
  end

  def self.validate_repo(repo_path)
    unless Dir.exists?("#{repo_path}/.git")
      puts "#{repo_path} is not a git repository"
      help
    end
  end

  def self.validate_out(out_path)
    unless Dir.exists?("#{out_path}")
      puts "#{out_path} doesn't exist"
      help
    end
  end
end
