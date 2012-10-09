module GitStats
  module GitData
    class Command
      def initialize(repo, command)
        @repo = repo
        @command = command
      end

      def run
        puts "running #@command"
        in_repo { %x[#@command] }
      end

      def in_repo
        Dir.chdir(@repo.path) { yield }
      end
    end
  end
end