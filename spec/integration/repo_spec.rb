require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:repo, path: 'spec/integration/test_repo', last_commit_hash: '45677ee') }
  let(:expected_authors) { [
      build(:author, repo: repo, name: "Tomasz Gieniusz", email: "tomasz.gieniusz@gmail.com"),
      build(:author, repo: repo, name: "John Doe", email: "john.doe@gmail.com"),
  ] }

  it 'should gather all authors' do
    repo.authors.should =~ expected_authors
  end

  it 'should gather all commits sorted by date' do
    repo.should have(10).commits
    repo.commits.should be_all { |e| e.is_a? GitStats::GitData::Commit }
    repo.commits.map(&:hash).should =~ %w(b3b4f81 d60b5ec ab47ef8 2c11f5e c87ecf9 b621a5d fd66657 81e8bef 4e7d0e9 45677ee)
  end

  it 'should return project name from dir' do
    repo.project_name.should == 'test_repo'
  end

  it 'should return project version as last commit hash' do
    repo.project_version.should == '45677ee'
  end

  it 'should count files in repo' do
    repo.files_count.should == 6
  end

  it 'should count all lines in repo' do
    repo.lines_count.should == 1114
  end

  it 'should count files by extension in repo' do
    repo.files_by_extension_count.should == {'.haml' => 1, '.txt' => 3, '.rb' => 2}
  end

  it 'should count lines by extension in repo' do
    repo.lines_by_extension.should == {'.haml' => 100, '.txt' => 1008, '.rb' => 6}
  end

  context 'activity' do
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

end