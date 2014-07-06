# -*- encoding : utf-8 -*-
module GitStats
  class Generator
    delegate :add_command_observer, to: :@repo
    delegate :render_all, to: :@view

    def initialize(options)
      validate_repo_path(options[:path])

      @repo = GitData::Repo.new(options)
      view_data = StatsView::ViewData.new(@repo)
      @view = StatsView::View.new(view_data, options[:out_path])

      yield self if block_given?
    end

    private


    def validate_repo_path(repo_path)
      raise ArgumentError, "#{repo_path} is not a git repository" unless valid_repo_path?(repo_path)
    end


    def valid_repo_path?(repo_path)
      Dir.exists?("#{repo_path}/.git") || File.exists?("#{repo_path}/.git") || File.exists?("#{repo_path}/HEAD")
    end

  end

end
