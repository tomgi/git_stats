# -*- encoding : utf-8 -*-
require "git_stats"

class GitStats::CLI

  def start(*args)
    raise "Wrong number of arguments\nUsage: git_stats repo_path output_path <output_lang>" unless [2, 3, 4, 5].include? args.size

    repo_path, out_path, lang, first_commit_sha, last_commit_sha = args
    I18n.locale = lang || :en

    GitStats::Generator.new(repo_path, out_path, first_commit_sha, last_commit_sha) { |g|
      g.add_command_observer { |command, result| puts "#{command}" }
    }.render_all
  end

end
