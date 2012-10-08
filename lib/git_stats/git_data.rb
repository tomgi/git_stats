require 'pathname'
require 'git_stats/git_author'
require 'git_stats/git_commit'

class GitStats::GitData
  attr_reader :total_authors
  attr_reader :total_commits

  def initialize(repo_path)
    @repo_path = repo_path
  end

  def gather_all_data
    @total_authors = run('git shortlog -s HEAD | wc -l')

    gather_commit_data
  end

  def gather_commit_data
    run('git rev-list --pretty=format:"%h|%at|%ai|%aN|%aE" HEAD | grep -v commit').split(/\r?\n/).each do |commit|
      hash, stamp, date, author_name, author_email = commit.split('|')
      authors[author_email] = GitStats::GitAuthor.new(name: author_name, email: author_email) unless authors[author_email]
      author = authors[author_email]
      commits[hash] = GitStats::GitCommit.new(hash: hash, stamp: stamp, date: date, author: author)
    end
  end

  def authors
    @authors ||= {}
  end

  def commits
    @commits ||= {}
  end

  def project_version
    @project_version ||= run('git rev-parse --short HEAD')
  end

  def project_name
    @project_name ||= Pathname(@repo_path).basename.to_s
  end

  def run(command)
    in_repo { %x[#{command}] }
  end

  def in_repo
    Dir.chdir(@repo_path) { yield }
  end
end
