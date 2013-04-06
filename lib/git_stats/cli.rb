# -*- encoding : utf-8 -*-
require "git_stats"
require "highline/import"

class GitStats::CLI

  def start

    repo_path = ask("Repo path?  ") { |q|
      q.default = "."
      q.validate = lambda { |p| GitStats::Validator.new.valid_repo_path?(p) }
      q.responses[:not_valid] = "Given path is not a git repository, try again"
    }

    out_path = ask("Output dir?  ") { |q| q.default = "./git_stats" }
    I18n.locale = ask("Language?  ") { |q| q.default = "en"; q.answer_type = Symbol }
    specify_range = agree("Want to specify commits range?  ") { |q| q.default = "no" }

    if specify_range
      first_commit_sha = ask("Starting commit sha?  ") { |q| q.default = nil }
      last_commit_sha = ask("Ending commit sha?  ") { |q| q.default = "HEAD" }
    end

    GitStats::Generator.new(repo_path, out_path, first_commit_sha, last_commit_sha) { |g|
      g.add_command_observer { |command, result| puts "#{command}" }
    }.render_all
  end

end
