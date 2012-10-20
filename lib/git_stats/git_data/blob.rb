require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Blob
      include HashInitializable

      attr_reader :repo, :hash, :filename

      def lines_count
        @lines_count ||= binary? ? 0 : repo.run("git cat-file blob #{self.hash} | wc -l").to_i
      end

      def content
        @content ||= repo.run("git cat-file blob #{self.hash}")
      end

      def extension
        @ext ||= File.extname(filename)
      end

      def binary?
        repo.run("git cat-file blob #{self.hash} | grep -m 1 '^'") =~ /Binary file/
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