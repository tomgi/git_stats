require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:test_repo, last_commit_hash: '872955c') }

  it 'should gather all files in repo' do
    repo.files.map(&:filename).should =~ %w(long_second.haml  long.txt  second.txt  test2.rb  test.rb  test.txt)
  end

  it 'should retrieve correct file content for old file' do
    repo.commits.by_hash('c87ecf9').files.by_filename('test.txt').content.should == "bb



test
"
  end

  it 'should retrieve correct file content for the newest file' do
    file = repo.files.by_filename('test.txt')
    file.content.should == "bb

testtest

test
"
  end


end