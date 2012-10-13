require 'spec_helper'

describe GitStats::GitData::Activity do
  let(:dates) { [
      '10.05.2012 12:37',
      '10.05.2012 13:53',
      '06.05.2012 13:23',
      '15.06.2011 15:02',
      '27.09.2011 15:34'
  ] }
  let(:commits) { dates.map { |d| double(:date => DateTime.parse(d)) } }
  let(:activity) { GitStats::GitData::Activity.new(commits) }

  it 'by_hour should count commits by hour' do
    activity.by_hour.should == {12 => 1, 13 => 2, 15 => 2}
  end

  it 'by_wday should count commits by day of week where 0 = sunday, 1 = monday, ...' do
    activity.by_wday.should == {0 => 1, 2 => 1, 3 => 1, 4 => 2}
  end

  it 'by_wday_hour should count commits by day of week and by hour' do
    activity.by_wday_hour.should == {0 => {13 => 1}, 2 => {15 => 1}, 3 => {15 => 1}, 4 => {12 => 1, 13 => 1}}
  end

  it 'by_month should count commits by month' do
    activity.by_month.should == {5 => 3, 6 => 1, 9 => 1}
  end

  it 'by_year should count commits by year' do
    activity.by_year.should == {2011 => 2, 2012 => 3}
  end

  it 'by_year_month should count commits by day of year and by month' do
    activity.by_year_month.should == {2011 => {6 => 1, 9 => 1}, 2012 => {5 => 3}}
  end
end