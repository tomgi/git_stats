module GitStats
  module GitData
    class Command
      def initialize(repo, command)
        @repo = repo
        @command = command
      end

      def run
        in_repo { %x[#@command] }
      end

      def in_repo
        Dir.chdir(@repo.path) { yield }
      end

      def to_s
        "#{self.class} #@command"
      end
    end
  end
end