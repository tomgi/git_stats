require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:test_repo, last_commit_sha: '872955c') }

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
    repo.files_count_each_day.should == [0, 3, 3, 5, 5, 5, 6, 6, 6]
  end

  it 'should count lines by date' do
    repo.lines_count_each_day.should == [0, 11, 11, 1014, 1014, 1014, 1114, 1114, 1114]
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