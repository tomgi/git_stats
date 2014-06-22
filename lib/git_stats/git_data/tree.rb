# -*- encoding : utf-8 -*-
require 'git_stats/hash_initializable'

module GitStats
  module GitData
    class Tree
      include HashInitializable

      attr_reader :repo, :relative_path

      def authors
        @authors ||= run_and_parse("git shortlog -se #{commit_range}").map do |author|
          Author.new(repo: self, name: author[:name], email: author[:email])
        end
      end
      
      def ==(other)
        ((self.repo == other.repo) && (self.relative_path == other.relative_path))
      end

    end
  end
end
