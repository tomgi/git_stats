module GitStats
  module GitData
    class CommandParser
      def parse(command, result)
        cmd, params = command.scan(/git (.*) (.*)/).first.map(&:split).flatten
        send("parse_#{cmd}", result, params)
      end

      def parse_shortlog(result, params)
        result.lines.map do |line|
          commits, name, email = line.scan(/(.*)\t(.*)<(.*)>/).first.map(&:strip)
          {commits: commits.to_i, name: name, email: email}
        end
      end
    end
  end
end