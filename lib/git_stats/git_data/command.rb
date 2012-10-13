module GitStats
  module GitData
    class Command
      attr_reader :repo, :command

      def initialize(repo, command)
        @repo = repo
        @command = command
      end

      def run
        repo.git_command_observer.try(:call, @command)
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