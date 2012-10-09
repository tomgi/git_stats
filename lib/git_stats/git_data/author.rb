require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Author
      include HashInitializable

      attr_accessor :name, :email

      def add_commit(commit)
        commits << commit
        activity.add_commit(commit)
      end

      def commits
        @commits ||= []
      end

      def activity
        @activity ||= Activity.new
      end
    end
  end
end