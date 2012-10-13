require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Commit
      include HashInitializable

      attr_reader :repo, :hash, :stamp, :date, :author

      def files
        @files ||= Command.new(repo, "git ls-tree -r #{self.hash}").run.lines.map do |line|
          hash = line.split("\t")[0].split.last.strip
          filename = line.split("\t")[1].strip
          Blob.new(repo: repo, filename: filename, hash: hash)
        end
      end

      def files_by_extension
        @files_by_extension ||= files.inject({}) { |acc, f| acc[f.extension] ||= []; acc[f.extension] << f; acc }
      end

      def lines_by_extension
        @lines_by_extension ||= Hash[files_by_extension.map { |ext, files| [ext, files.map(&:lines_count).sum] }]
      end

      def files_count
        @files_count ||= Command.new(repo, "git ls-tree -r --name-only #{self.hash} | wc -l").run.to_i
      end

      def lines_count
        @lines_count ||= Command.new(repo, "git diff --shortstat `git hash-object -t tree /dev/null` #{self.hash}").run.lines.map do |line|
          line[/(\d+) insertions?/, 1].to_i
        end.sum
      end

      def short_stat
        @short_stat ||= ShortStat.new(self)
      end

      def to_s
        "#{self.class} #@hash"
      end

      def ==(other)
        [self.repo, self.hash, self.stamp, self.date, self.author] ==
            [other.repo, other.hash, other.stamp, other.date, other.author]
      end
    end
  end
end