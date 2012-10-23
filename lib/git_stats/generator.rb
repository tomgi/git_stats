# -*- encoding : utf-8 -*-
module GitStats
  class Generator
    delegate :add_command_observer, to: :@repo
    delegate :render_all, to: :@view

    def initialize(repo_path, out_path)
      validate_paths(repo_path, out_path)

      @repo = GitData::Repo.new(path: repo_path)
      view_data = StatsView::ViewData.new(@repo)
      @view = StatsView::View.new(view_data, out_path)

      yield self if block_given?
    end

    private
    def validate_paths(repo_path, out_path)
      validate_repo_path(repo_path)
      validate_out_path(out_path)
    end

    def validate_repo_path(repo_path)
      raise ArgumentError, "#{repo_path} is not a git repository" unless Dir.exists?("#{repo_path}/.git")
    end

    def validate_out_path(out_path)
      raise ArgumentError, "#{out_path} is not a directory" unless Dir.exists?(out_path)
    end
  end

end
