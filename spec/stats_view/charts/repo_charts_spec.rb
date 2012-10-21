require 'spec_helper'

shared_examples_for "column_chart" do
  it 'should be a column chart' do
    chart.should be_a GitStats::StatsView::Charts::Chart
    chart.options[:chart][:type].should == "column"
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
    let(:repo) { double(commits: [double(date: 5)], files_count_by_date: {1 => 10, 2 => 15, 3 => 12, 5 => 20}) }
    let(:chart) { charts.files_by_date }

    it 'should have 1 data series with files_by_date' do
      chart.should have(1).data
      chart.data[0][:data].should == [[1000, 10], [2000, 15], [3000, 12], [5000, 20]]
    end
  end

  context 'lines_by_date chart' do
    let(:repo) { double(commits: [double(date: 6)], lines_count_by_date: {1 => 100, 2 => 150, 3 => 120, 5 => 200}) }
    let(:chart) { charts.lines_by_date }

    it 'should have 1 data series with lines_by_date' do
      chart.should have(1).data
      chart.data[0][:data].should == [[1000, 100], [2000, 150], [3000, 120], [5000, 200]]
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