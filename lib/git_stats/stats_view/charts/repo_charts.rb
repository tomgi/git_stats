module GitStats
  module StatsView
    module Charts
      class RepoCharts
        def initialize(repo)
          @repo = repo
        end

        [:lines, :files].each do |type|
          define_method "#{type}_by_extension" do
            Chart.new do |f|
              f.column_hash_chart(
                  data: @repo.send("#{type}_by_extension_count"),
                  title: "#{type}_extension".to_sym.t,
                  y_text: type.to_sym.t
              )
            end
          end

          define_method "#{type}_by_date" do
            Chart.new do |f|
              f.date_chart(
                  data: @repo.send("#{type}_count_by_date"),
                  title: "#{type}_by_date".to_sym.t,
                  y_text: type.to_sym.t
              )
            end
          end
        end

        [:commits_count_by_author, :insertions_by_author, :deletions_by_author].each do |method|
          define_method method do
            Chart.new do |f|
              f.column_hash_chart(
                  data: Hash[@repo.send(method).map { |a, l| [a.email, l] }],
                  title: method.t,
                  y_text: method.to_s.split('_').first.to_sym
              )
            end
          end
        end

      end
    end
  end
end
