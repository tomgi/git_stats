require 'spec_helper'

shared_examples_for "column_chart" do
  it 'should be a column chart' do
    chart.should be_a GitStats::StatsView::Charts::Chart
    chart.options[:chart][:type].should == "column"
  end
end

shared_examples_for "datetime_chart" do
  it 'should be a datetime chart' do
    chart.should be_a GitStats::StatsView::Charts::Chart
    chart.options[:xAxis][:type].should == "datetime"
  end
end

describe GitStats::StatsView::Charts::RepoCharts do
  let(:charts) { GitStats::StatsView::Charts::All.new(repo) }

  context 'files_by_extension chart' do
    let(:repo) { double(files_by_extension_count: {'.rb' => 5, '.txt' => 3}) }
    let(:chart) { charts.files_by_extension }

    it_behaves_like "column_chart"

    it 'should have 1 data series with files_by_extension_count' do
      chart.should have(1).data
      chart.options[:xAxis][:categories].should == %w(.rb .txt)
      chart.data[0][:data].should == [5, 3]
    end
  end

  context 'lines_by_extension chart' do
    let(:repo) { double(lines_by_extension: {'.rb' => 50, '.txt' => 30}) }
    let(:chart) { charts.lines_by_extension }

    it_behaves_like "column_chart"

    it 'should have 1 data series with lines_by_extension' do
      chart.should have(1).data
      chart.options[:xAxis][:categories].should == %w(.rb .txt)
      chart.data[0][:data].should == [50, 30]
    end
  end

  context 'files_by_date chart' do
    let(:repo) { double(commits: [double(date: 5)], files_count_each_day: [10, 15, 12, 20]) }
    let(:chart) { charts.files_by_date }

    it_behaves_like "datetime_chart"

    it 'should have 1 data series with files_by_date' do
      chart.should have(1).data
      chart.data[0][:data].should == [10, 15, 12, 20]
      chart.data[0][:pointStart].should == 5000
    end
  end

  context 'lines_by_date chart' do
    let(:repo) { double(commits: [double(date: 6)], lines_count_each_day: [100, 150, 120, 200]) }
    let(:chart) { charts.lines_by_date }

    it_behaves_like "datetime_chart"

    it 'should have 1 data series with lines_by_date' do
      chart.should have(1).data
      chart.data[0][:data].should == [100, 150, 120, 200]
      chart.data[0][:pointStart].should == 6000
    end
  end

  context 'lines_added_by_author chart' do
    let(:repo) { double(commits: [double(date: 6)], lines_added_by_author: {double(email: 'author1') => 50, double(email: 'author2') => 30}) }
    let(:chart) { charts.lines_added_by_author }

    it_behaves_like "column_chart"

    it 'should have 1 data series with lines_added_by_author' do
      chart.should have(1).data
      chart.options[:xAxis][:categories].should == %w(author1 author2)
      chart.data[0][:data].should == [50, 30]
    end
  end

  context 'lines_deleted_by_author chart' do
    let(:repo) { double(commits: [double(date: 6)], lines_deleted_by_author: {double(email: 'author1') => 30, double(email: 'author2') => 50}) }
    let(:chart) { charts.lines_deleted_by_author }

    it_behaves_like "column_chart"

    it 'should have 1 data series with lines_deleted_by_author' do
      chart.should have(1).data
      chart.options[:xAxis][:categories].should == %w(author1 author2)
      chart.data[0][:data].should == [30, 50]
    end
  end
end