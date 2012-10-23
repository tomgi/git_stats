# -*- encoding : utf-8 -*-
module GitStats
  module StatsView
    module Charts
      class All
        delegate :files_by_extension, :lines_by_extension, :files_by_date, :lines_by_date, to: :repo_charts

        delegate :commits_sum_by_author_by_date, :changed_lines_by_author_by_date,
                 :insertions_by_author_by_date, :deletions_by_author_by_date, to: :authors_charts

        delegate :activity_by_date, :activity_by_hour, :activity_by_wday, :activity_by_month,
                 :activity_by_year, to: :activity_charts

        attr_reader :repo

        def initialize(repo)
          @repo = repo
        end

        def repo_charts
          @repo_charts ||= Charts::RepoCharts.new(repo)
        end

        def authors_charts
          @authors_charts ||= Charts::AuthorsCharts.new(repo.authors)
        end

        def activity_charts
          @activity_charts ||= Charts::ActivityCharts.new(repo)
        end

      end
    end
  end
end
