# -*- encoding : utf-8 -*-
require 'integration/shared'

describe GitStats::GitData::Repo do
  include_context "shared"

  it 'should gather all files in repo' do
    repo.files.map(&:filename).should =~ %w(long_second.haml  long.txt  second.txt  test2.rb  test.rb  test.txt)
  end

  it 'should retrieve correct file content for old file' do
    repo.commits.first! { |c| c.sha == 'c87ecf9' }.files.first! { |f| f.filename == 'test.txt' }.content.should == "bb



test
"
  end

  it 'should retrieve correct file content for the newest file' do
    file = repo.files.first! { |f| f.filename == 'test.txt' }
    file.content.should == "bb

testtest

test
"
  end


end
