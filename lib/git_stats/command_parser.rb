# -*- encoding : utf-8 -*-
module GitStats
  class CommandParser
    def parse(command, result)
      cmd, params = command.scan(/git (.*) (.*)/).first.map(&:split).flatten
      send("parse_#{cmd.underscore}", result, params)
    end

    def parse_shortlog(result, params)
      result.lines.map do |line|
        commits, name, email = line.scan(/(.*)\t(.*)<(.*)>/).first.map(&:strip)
        {commits: commits.to_i, name: name, email: email}
      end
    end

    def parse_ls_tree(result, params)
      result.lines.map do |line|
        mode, type, sha, filename = line.scan(/(.*) (.*) (.*)\t(.*)/).first.map(&:strip)
        {mode: mode, type: type, sha: sha, filename: filename}
      end
    end

    def parse_rev_list(result, params)
      result.lines.map do |line|
        sha, stamp, date, author_email = line.split('|').map(&:strip)
        {sha: sha, stamp: stamp, date: date, author_email: author_email}
      end
    end

  end
end
