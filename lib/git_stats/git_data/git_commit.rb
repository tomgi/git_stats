require 'git_stats/hash_initializable'

class GitStats::GitCommit
  include HashInitializable

  attr_accessor :hash, :stamp, :date, :author
end