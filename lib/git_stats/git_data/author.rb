require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Author
      include HashInitializable

      attr_reader :repo, :name, :email

      def add_commit(commit)
        commits << commit
        activity.add_commit(commit)
      end

      def commits
        @commits ||= repo.commits.select { |hash, commit| commit.author == self }
      end

      def activity
        @activity ||= Activity.new(commits)
      end

    end
  end
end