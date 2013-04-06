# -*- encoding : utf-8 -*-
module GitStats
  class Validator

    def valid_repo_path?(repo_path)
      Dir.exists?("#{repo_path}/.git") || File.exists?("#{repo_path}/HEAD")
    end

  end
end