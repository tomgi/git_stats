require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Commit
      include HashInitializable

      attr_reader :repo, :hash, :stamp, :date, :author

      def files_count
        @files_count ||= Command.new(repo, "git ls-tree -r --name-only #{self.hash} | wc -l").run.to_i
      end

      def short_stat
        @short_stat ||= ShortStat.new(self)
      end
    end
  end
end