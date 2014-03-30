# -*- encoding : utf-8 -*-
require 'integration/shared'

describe GitStats::GitData::Tree do
  include_context "tree"

  it 'should gather all authors' do
    repo.authors.should =~ expected_authors
  end

  it 'should calculate correct commits period' do
    repo.commits_period.should == [DateTime.parse('2014-03-21 14:11:46 +0100'),
                                   DateTime.parse('2014-03-21 14:12:47 +0100')]
  end

  it 'should gather all commits sorted by date' do
    repo.commits.map(&:sha).should =~ %w(10d1814 435e0ef 5fd0f5e)
  end

  it 'should return project name from dir' do
    repo.project_name.should == 'test_repo_tree'
  end

  it 'should return project version as last commit hash' do
    repo.project_version.should == '5fd0f5e'
  end

  it 'should count files in repo' do
    repo.files_count.should == 4
  end

  it 'should count files by date' do
    repo.files_count_by_date.keys == Hash[commit_dates_with_empty.zip [2, 3, 4]]
  end

  it 'should count lines by date' do
    repo.files_count_by_date.values == Hash[commit_dates_with_empty.zip [1, 2, 2]]
  end

  it 'should count all lines in repo' do
    repo.lines_count.should == 0
  end

  it 'should count files by extension in repo' do
    repo.files_by_extension_count.should == {'' => 4}
  end

  it 'should count lines by extension in repo' do
    repo.lines_by_extension.should == {}
  end

  it 'should count commits_count_by_author' do
    repo.commits_count_by_author.keys.should == expected_authors
    repo.commits_count_by_author.values.should == [3]
  end

  it 'should count lines_added_by_author' do
    repo.insertions_by_author.keys.should == expected_authors
    repo.insertions_by_author.values.should == [0]
  end

  it 'should count lines_deleted_by_author' do
    repo.deletions_by_author.keys.should == expected_authors
    repo.deletions_by_author.values.should == [0]
  end

end

describe GitStats::GitData::Tree do
  include_context "tree_subdir_with_1_commit"

  it 'should gather all authors' do
    repo.authors.should =~ expected_authors
  end

  it 'should calculate correct commits period' do
    repo.commits_period.should == [DateTime.parse('2014-03-21 14:11:46 +0100'),
                                   DateTime.parse('2014-03-21 14:11:46 +0100')]
  end

  it 'should gather all commits sorted by date' do
    repo.commits.map(&:sha).should =~ %w(10d1814)
  end

  it 'should return project name from dir' do
    repo.project_name.should == 'test_repo_tree/subdir_with_1_commit'
  end

  it 'should return project version as last commit hash' do
    repo.project_version.should == '5fd0f5e'
  end

  it 'should count files in repo' do
    repo.files_count.should == 2
  end

  it 'should count files by date' do
    repo.files_count_by_date.keys == Hash[commit_dates_with_empty.zip [2]]
  end

  it 'should count lines by date' do
    repo.files_count_by_date.values == Hash[commit_dates_with_empty.zip [1]]
  end

  it 'should count all lines in repo' do
    repo.lines_count.should == 0
  end

  it 'should count files by extension in repo' do
    repo.files_by_extension_count.should == {'' => 2}
  end

  it 'should count lines by extension in repo' do
    repo.lines_by_extension.should == {}
  end

  it 'should count commits_count_by_author' do
    repo.commits_count_by_author.keys.should == expected_authors
    repo.commits_count_by_author.values.should == [1]
  end

  it 'should count lines_added_by_author' do
    repo.insertions_by_author.keys.should == expected_authors
    repo.insertions_by_author.values.should == [0]
  end

  it 'should count lines_deleted_by_author' do
    repo.deletions_by_author.keys.should == expected_authors
    repo.deletions_by_author.values.should == [0]
  end

end

describe GitStats::GitData::Tree do
  include_context "tree_subdir_with_2_commit"

  it 'should gather all authors' do
    repo.authors.should =~ expected_authors
  end

  it 'should calculate correct commits period' do
    repo.commits_period.should == [DateTime.parse('2014-03-21 14:12:23 +0100'),
                                   DateTime.parse('2014-03-21 14:12:47 +0100')]
  end

  it 'should gather all commits sorted by date' do
    repo.commits.map(&:sha).should =~ %w(435e0ef 5fd0f5e)
  end

  it 'should return project name from dir' do
    repo.project_name.should == 'test_repo_tree/subdir_with_2_commits'
  end

  it 'should return project version as last commit hash' do
    repo.project_version.should == '5fd0f5e'
  end

  it 'should count files in repo' do
    repo.files_count.should == 2
  end

  it 'should count files by date' do
    repo.files_count_by_date.keys == Hash[commit_dates_with_empty.zip [1, 2]]
  end

  it 'should count lines by date' do
    repo.files_count_by_date.values == Hash[commit_dates_with_empty.zip [2, 2]]
  end

  it 'should count all lines in repo' do
    repo.lines_count.should == 0
  end

  it 'should count files by extension in repo' do
    repo.files_by_extension_count.should == {'' => 2}
  end

  it 'should count lines by extension in repo' do
    repo.lines_by_extension.should == {}
  end

  it 'should count commits_count_by_author' do
    repo.commits_count_by_author.keys.should == expected_authors
    repo.commits_count_by_author.values.should == [2]
  end

  it 'should count lines_added_by_author' do
    repo.insertions_by_author.keys.should == expected_authors
    repo.insertions_by_author.values.should == [0]
  end

  it 'should count lines_deleted_by_author' do
    repo.deletions_by_author.keys.should == expected_authors
    repo.deletions_by_author.values.should == [0]
  end

end
