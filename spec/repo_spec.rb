require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:repo) }
  let(:expected_authors) { [
      build(:author, repo: repo, name: "John Doe", email: "john.doe@gmail.com"),
      build(:author, repo: repo, name: "Joe Doe", email: "joe.doe@gmail.com")
  ] }

  describe 'commit range' do
    it 'should return HEAD by default' do
      repo.commit_range.should == 'HEAD'
    end

    it 'should return last_commit if it was given' do
      repo = build(:repo, last_commit: 'abc')
      repo.commit_range.should == 'abc'
    end

    it 'should return range from first_commit to HEAD if first_commit was given' do
      repo = build(:repo, first_commit: 'abc')
      repo.commit_range.should == 'abc..HEAD'
    end

    it 'should return range from first to last commit if both were given' do
      repo = build(:repo, first_commit: 'abc', last_commit: 'def')
      repo.commit_range.should == 'abc..def'
    end
  end

  describe 'git output parsing' do
    before do
      repo.should_receive(:run).with('git shortlog -se HEAD').and_return("   156	John Doe <john.doe@gmail.com>
    53	Joe Doe <joe.doe@gmail.com>
")
    end

    it 'should parse git shortlog output to authors hash' do
      repo.authors.should == expected_authors
    end

    it 'should parse git revlist output to date sorted commits array' do
      repo.should_receive(:run).with('git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').and_return(
          "e4412c3|1348603824|2012-09-25 22:10:24 +0200|john.doe@gmail.com
ce34874|1347482927|2012-09-12 22:48:47 +0200|joe.doe@gmail.com
5eab339|1345835073|2012-08-24 21:04:33 +0200|john.doe@gmail.com
")

      repo.commits.should == [
          GitStats::GitData::Commit.new(
              repo: repo, hash: "5eab339", stamp: "1345835073", date: DateTime.parse("2012-08-24 21:04:33 +0200"),
              author: repo.authors.by_email("john.doe@gmail.com")),
          GitStats::GitData::Commit.new(
              repo: repo, hash: "ce34874", stamp: "1347482927", date: DateTime.parse("2012-09-12 22:48:47 +0200"),
              author: repo.authors.by_email("joe.doe@gmail.com")),
          GitStats::GitData::Commit.new(
              repo: repo, hash: "e4412c3", stamp: "1348603824", date: DateTime.parse("2012-09-25 22:10:24 +0200"),
              author: repo.authors.by_email("john.doe@gmail.com"))
      ]
    end
  end
end