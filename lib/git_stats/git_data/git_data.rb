class GitStats::GitData
  attr_reader :repo

  def initialize(repo)
    @repo = repo
  end

  def gather_all
    gather_authors
    gather_commits
  end

  def gather_authors
    GitStats::GitCommand.new(repo, 'git shortlog -se HEAD').run.each_line do |author|
      name, email = author.split(/\t/)[1].strip.scan(/(.*)<(.*)>/).first.map(&:strip)
      authors[email] = GitStats::GitAuthor.new(name: name, email: email)
    end
  end

  def gather_commits
    GitStats::GitCommand.new(repo, 'git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').run.each_line do |commit_line|
      hash, stamp, date, author_email = commit_line.split('|').map(&:strip)
      author = authors[author_email]

      date = DateTime.parse(date)
      commit = commits[hash] = GitStats::GitCommit.new(repo: repo, hash: hash, stamp: stamp, date: date, author: author)

      activity.add_commit(commit)
      author.activity.add_commit(commit)
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
    @project_version ||= GitStats::GitCommand.new(repo, 'git rev-parse --short HEAD').run
  end

  def project_name
    @project_name ||= Pathname(repo.path).basename.to_s
  end

end
