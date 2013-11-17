# -*- encoding : utf-8 -*-
module GitStats
  module GitData
    class CommentStat
      attr_reader :commit, :insertions, :deletions

      def initialize(commit)
        @commit = commit
        calculate_stat
      end

      def changed_lines
        insertions + deletions
      end

      def to_s
        "#{self.class} #@commit"
      end

      private
      def calculate_stat
        stat_line = commit.repo.run("git show #{commit.sha} | awk 'BEGIN {adds=0; dels=0} {if ($0 ~ /^\\+\\/\\/\\//) adds++; if ($0 ~ /^\-\\/\\/\\//) dels++} END {print adds \" insertions \" dels \" deletes\"}'").lines.to_a[0]
        if stat_line.blank?
          @insertions = @deletions = 0
        else
          @insertions = stat_line[/(\d+) insertions?/, 1].to_i
          @deletions = stat_line[/(\d+) deletes?/, 1].to_i
        end
      end
    end
  end
end
