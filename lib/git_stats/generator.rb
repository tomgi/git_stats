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
      raise ArgumentError, "#{repo_path} is not a git repository" unless Validator.new.valid_repo_path?(repo_path)
    end

  end

end
