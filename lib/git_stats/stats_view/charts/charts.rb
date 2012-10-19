module GitStats
  module StatsView
    module Charts
      class All
        delegate :files_by_extension, :lines_by_extension, :files_by_date, :lines_by_date, to: :repo_charts
        delegate :by_authors_wday, to: :authors_charts
        delegate :activity_by_hour, to: :activity_charts

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
          @activity_charts ||= Charts::ActivityCharts.new(repo.activity)
        end

      end
    end
  end
end