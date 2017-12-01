# -*- encoding : utf-8 -*-
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
    repo.commits.map(&:sha).should =~ %w(
      2c11f5e5224dd7d2fab27de0fca2a9a1d0ca4038
      4e7d0e9e58e27e33d47f94faf4079a49a75931da
      81e8bef75eaa93d772f2ce11d2a266ada1292741
      872955c3a6a4be4d7ae9b2dd4bea659979f0b457
      ab47ef832c59837afcb626bfe22f0b8f0dc3717e
      b3b4f819041eb66922abe79ee2513d5ddfb64691
      b621a5df78e2953a040128191e47a24be9514b5c
      c87ecf9c0bbdca29d73def8ed442cebf48178d92
      d60b5eccf4513621bdbd65f408a0d28ff6fa9f5b
      fd66657521139b1af6fde2927c4a383ecd6508fa
    )
  end

  it 'should return project name from dir' do
    repo.project_name.should == 'test_repo'
  end

  it 'should return project version as last commit hash' do
    repo.project_version.should == '872955c3a6a4be4d7ae9b2dd4bea659979f0b457'
  end

  it 'should count files in repo' do
    repo.files_count.should == 6
  end

  it 'should count files by date' do
    repo.files_count_by_date.keys == Hash[commit_dates_with_empty.zip [1, 2, 2, 3, 3, 4, 5, 5, 6, 6]]
  end

  it 'should count lines by date' do
    repo.files_count_by_date.values == Hash[commit_dates_with_empty.zip [1, 2, 2, 3, 3, 4, 5, 5, 6, 6]]
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
