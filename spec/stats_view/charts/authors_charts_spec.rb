require 'spec_helper'

describe GitStats::StatsView::Charts::AuthorsCharts do
  let(:charts) { GitStats::StatsView::Charts::All.new(repo) }

  context 'by_authors_wday chart' do
    let(:authors) { [
        double(email: "email1", activity: double(by_wday: double(to_key_indexed_array: "result1"))),
        double(email: "email2", activity: double(by_wday: double(to_key_indexed_array: "result2")))
    ] }
    let(:repo) { double(authors: authors) }
    let(:chart) { charts.authors_charts.by_authors_wday }

    it 'should be a column chart' do
      chart.should be_a GitStats::StatsView::Charts::Chart
      chart.options[:chart][:type].should == "column"
    end

    it 'should have 2 data series with authors activity by_wday' do
      chart.should have(2).data
      chart.data[0][:data].should == "result1"
      chart.data[0][:name].should == "email1"

      chart.data[1][:data].should == "result2"
      chart.data[1][:name].should == "email2"
    end
  end
end