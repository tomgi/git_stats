class GitStats::GitData

  def initialize(repo_path)
    @repo_path = repo_path
    gather_all
  end

  def gather_all
    gather_authors
    gather_commits
  end

  def gather_authors
    run('git shortlog -se HEAD').each_line do |author|
      name, email = author.split(/\t/)[1].strip.scan(/(.*)<(.*)>/).first.map(&:strip)
      authors[email] = GitStats::GitAuthor.new(name: name, email: email)
    end
  end

  def gather_commits
    run('git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').each_line do |commit|
      hash, stamp, date, author_email = commit.split('|').map(&:strip)
      author = authors[author_email]

      date = DateTime.parse(date)
      commits[hash] = GitStats::GitCommit.new(hash: hash, stamp: stamp, date: date, author: author)

      activity.add_commit(date)
      author.activity.add_commit(date)
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
