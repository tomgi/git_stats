require 'git_stats/hash_initializable'

class GitStats::GitAuthor
  include HashInitializable

  attr_accessor :name, :email
end