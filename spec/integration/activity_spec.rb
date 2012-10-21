require 'integration/shared'

describe GitStats::GitData::Activity do
  include_context "shared"

  let(:activity) { repo.activity }

  it 'should count commits by hour' do
    activity.by_hour.should == {10 => 4, 12 => 3, 13 => 1, 15 => 1, 17 => 1}
  end

  it 'should count commits by day of week' do
    activity.by_wday.should == {0 => 3, 3 => 1, 5 => 5, 6 => 1}
  end

  it 'should count commits by day of week and hour' do
    activity.by_wday_hour.should == {0 => {12 => 2, 13 => 1}, 3 => {15 => 1}, 5 => {10 => 4, 17 => 1}, 6 => {12 => 1}}
  end

  it 'should count commits by month' do
    activity.by_month.should == {10 => 10}
  end

  it 'should count commits by year' do
    activity.by_year.should == {2012 => 10}
  end

  it 'should count commits by year and month' do
    activity.by_year_month.should == {2012 => {10 => 10}}
  end

end