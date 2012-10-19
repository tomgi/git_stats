module GitStats
  module GitData
    class CommandRunner
      def self.run(command)
        %x[#{command}]
      end
    end
  end
end