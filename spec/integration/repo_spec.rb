require 'integration/shared'

describe GitStats::GitData::Repo do
  include_context "shared"

  it 'should gather all authors' do
    repo.authors.should =~ expected_authors
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
    repo.lines_by_extension_count.should == {'.haml' => 100, '.txt' => 1008, '.rb' => 6}
  end

  it 'should count commits_count_by_author' do
    repo.commits_count_by_author.keys.should == expected_authors
    repo.commits_count_by_author.values.should == [8, 2]
  end

  it 'should count lines_added_by_author' do
    repo.insertions_by_author.keys.should == expected_authors
    repo.insertions_by_author.values.should == [1021, 103]
  end

  it 'should count lines_deleted_by_author' do
    repo.deletions_by_author.keys.should == expected_authors
    repo.deletions_by_author.values.should == [10, 0]
  end

end