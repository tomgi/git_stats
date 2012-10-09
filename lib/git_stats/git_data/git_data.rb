class GitStats::GitData
  attr_reader :total_authors
  attr_reader :total_commits

  def initialize(repo_path)
    @repo_path = repo_path
    gather_all
  end

  def gather_all
    @total_authors = run('git shortlog -s HEAD | wc -l')

    gather_commits
  end

  def gather_commits
    run('git rev-list --pretty=format:"%h|%at|%ai|%aN|%aE" HEAD | grep -v commit').split(/\r?\n/).each do |commit|
      hash, stamp, date, author_name, author_email = commit.split('|')

      authors[author_email] = GitStats::GitAuthor.new(name: author_name, email: author_email) unless authors[author_email]
      author = authors[author_email]

      date = DateTime.parse(date)
      commits[hash] = GitStats::GitCommit.new(hash: hash, stamp: stamp, date: date, author: author)

      activity.by_hour[date.hour] += 1
      activity.by_wday[date.wday] += 1
      activity.by_wday_hour[date.wday][date.hour] += 1

      author.activity.by_hour[date.hour] += 1
      author.activity.by_wday[date.wday] += 1
      author.activity.by_wday_hour[date.wday][date.hour] += 1
    end
  end

  def authors
    @authors ||= {}
  end

  def commits
    @commits ||= {}
  end

  def activity
    @activity ||= GitStats::GitActivity.new
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
