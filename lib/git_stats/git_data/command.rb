module GitStats
  module GitData
    class Command
      attr_reader :repo, :command

      def initialize(repo, command)
        @repo = repo
        @command = command
      end

      def run
        result = run_in_repo { %x[#@command] }
        repo.git_command_observer.try(:call, @command, result)
        result
      end

      def run_in_repo
        Dir.chdir(@repo.path) { yield }
      end

      def to_s
        "#{self.class} #@command"
      end
    end
  end
end