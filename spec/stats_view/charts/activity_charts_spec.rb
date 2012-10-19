require 'spec_helper'

describe GitStats::StatsView::Charts::ActivityCharts do
  let(:charts) { GitStats::StatsView::Charts::All.new(repo) }

  context 'activity_by_hour chart' do
    let(:activity) { double(by_hour: double(to_key_indexed_array: 'result')) }
    let(:repo) { double(activity: activity) }
    let(:chart) { charts.activity_charts.activity_by_hour }

    it 'should be a column chart' do
      chart.should be_a GitStats::StatsView::Charts::Chart
      chart.options[:chart][:type].should == "column"
    end

    it 'should have 1 data series with activity by_hour' do
      chart.should have(1).data
      chart.data.first[:data].should == activity.by_hour.to_key_indexed_array
    end
  end
end