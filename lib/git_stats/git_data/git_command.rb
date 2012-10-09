class GitStats::GitCommand
  def initialize(repo, command)
    @repo = repo
    @command = command
  end

  def run
    in_repo { %x[#@command] }
  end

  def in_repo
    Dir.chdir(@repo.path) { yield }
  end
end