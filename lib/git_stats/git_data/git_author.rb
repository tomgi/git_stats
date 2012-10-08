require 'git_stats/hash_initializable'

class GitStats::GitAuthor
  include HashInitializable

  attr_accessor :name, :email

  def activity
    @activity ||= GitStats::GitActivity.new
  end
end