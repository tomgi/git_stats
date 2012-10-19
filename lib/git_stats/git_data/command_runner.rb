module GitStats
  module GitData
    class CommandRunner
      def run(path, command)
        Dir.chdir(path) { %x[#{command}] }
      end
    end
  end
end