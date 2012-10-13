require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Blob
      include HashInitializable

      attr_reader :repo, :hash, :filename

      def lines_count
        @lines_count ||= Command.new(repo, "git cat-file blob #{self.hash} | wc -l").run.to_i
      end

      def content
        @content ||= Command.new(repo, "git cat-file blob #{self.hash}").run
      end

      def to_s
        "#{self.class} #@hash #@filename"
      end

      def ==(other)
        [self.repo, self.hash, self.filename] == [other.repo, other.hash, other.filename]
      end

    end
  end
end