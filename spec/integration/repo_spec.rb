require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:test_repo, last_commit_sha: '872955c') }
  let(:commit_dates) { [
      DateTime.parse('2012-10-19 10:44:34 +0200'),
      DateTime.parse('2012-10-19 10:46:10 +0200'),
      DateTime.parse('2012-10-19 10:46:56 +0200'),
      DateTime.parse('2012-10-19 10:47:35 +0200'),
      DateTime.parse('2012-10-20 12:49:02 +0200'),
      DateTime.parse('2012-10-21 12:49:02 +0200'),
      DateTime.parse('2012-10-21 12:54:02 +0200'),
      DateTime.parse('2012-10-21 13:20:00 +0200'),
      DateTime.parse('2012-10-24 15:49:02 +0200'),
      DateTime.parse('2012-10-26 17:05:25 +0200'),
  ] }

  it 'should gather all authors' do
    repo.authors.should =~ [
        build(:author, repo: repo, name: "Tomasz Gieniusz", email: "tomasz.gieniusz@gmail.com"),
        build(:author, repo: repo, name: "John Doe", email: "john.doe@gmail.com"),
    ]
  end

  it 'should calculate correct commits period' do
    repo.commits_period.should == [DateTime.parse('2012-10-19 10:44:34 +0200'), DateTime.parse('2012-10-26 17:05:25 +0200')]
  end

  it 'should gather all commits sorted by date' do
    repo.commits.map(&:sha).should =~ %w(b3b4f81 d60b5ec ab47ef8 2c11f5e c87ecf9 b621a5d fd66657 81e8bef 4e7d0e9 872955c)
  end

  it 'should return project name from dir' do
    repo.project_name.should == 'test_repo'
  end

  it 'should return project version as last commit hash' do
    repo.project_version.should == '872955c'
  end

  it 'should count files in repo' do
    repo.files_count.should == 6
  end

  it 'should count files by date' do
    repo.files_count_by_date.keys.should == commit_dates
    repo.files_count_by_date.values.should == [1, 2, 2, 3, 3, 4, 5, 5, 6, 6]
  end

  it 'should count lines by date' do
    repo.lines_count_by_date.keys.should == commit_dates
    repo.files_count_by_date.values.should == [1, 2, 2, 3, 3, 4, 5, 5, 6, 6]
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

end