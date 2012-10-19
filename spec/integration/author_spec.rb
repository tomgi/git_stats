require 'spec_helper'

describe GitStats::GitData::Activity do
  let(:repo) { build(:test_repo, last_commit_hash: '45677ee') }

  let(:tg) { repo.authors.by_email('tomasz.gieniusz@gmail.com') }
  let(:jd) { repo.authors.by_email('john.doe@gmail.com') }

  it 'should filter commits to author' do
    tg.commits.map(&:hash).should =~ %w(b3b4f81 d60b5ec ab47ef8 2c11f5e c87ecf9 b621a5d 4e7d0e9 45677ee)
    jd.commits.map(&:hash).should =~ %w(fd66657 81e8bef)
  end

  context 'activity' do
    it 'should count commits by hour' do
      tg.activity.by_hour.should == {10 => 4, 12 => 2, 13 => 1, 17 => 1}
      jd.activity.by_hour.should == {12 => 1, 15 => 1}
    end

    it 'should count commits by day of week' do
      tg.activity.by_wday.should == {0 => 2, 5 => 5, 6 => 1}
      jd.activity.by_wday.should == {0 => 1, 3 => 1}
    end

    it 'should count commits by day of week and hour' do
      tg.activity.by_wday_hour.should == {0 => {12 => 1, 13 => 1}, 5 => {10 => 4, 17 => 1}, 6 => {12 => 1}}
      jd.activity.by_wday_hour.should == {0 => {12 => 1}, 3 => {15 => 1}}
    end

    it 'should count commits by month' do
      tg.activity.by_month.should == {10 => 8}
      jd.activity.by_month.should == {10 => 2}
    end

    it 'should count commits by year' do
      tg.activity.by_year.should == {2012 => 8}
      jd.activity.by_year.should == {2012 => 2}
    end

    it 'should count commits by year and month' do
      tg.activity.by_year_month.should == {2012 => {10 => 8}}
      jd.activity.by_year_month.should == {2012 => {10 => 2}}
    end
  end
end