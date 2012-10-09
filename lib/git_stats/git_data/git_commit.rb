require 'git_stats/hash_initializable'

class GitStats::GitCommit
  include HashInitializable

  attr_accessor :repo, :hash, :stamp, :date, :author

  def files
    @files ||= GitStats::GitCommand.new(repo, "git ls-tree -r --name-only #{self.hash}").run.split(/\r?\n/).map(&:strip)
  end
end