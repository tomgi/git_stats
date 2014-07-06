# -*- encoding : utf-8 -*-
module GitStats
  class CommandRunner
    def run(path, command)
      execute(command, path).encode!('UTF-8', 'UTF-8', :invalid => :replace)
    end

    private
    def execute(command, path)
      Dir.chdir(path) { %x[#{command}] }
    end
  end
end
