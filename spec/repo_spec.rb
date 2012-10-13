require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { GitStats::GitData::Repo.new("repo_path") }

  describe 'git output parsing' do
    before {
      GitStats::GitData::Command.should_receive(:new).with(
          repo, 'git shortlog -se HEAD').and_return(
          double(:run => "   156	John Doe <john.doe@gmail.com>
    53	Joe Doe <joe.doe@gmail.com>
"))
    }

    it 'should parse git shortlog output to authors hash' do
      repo.authors.should == {
          "john.doe@gmail.com" => GitStats::GitData::Author.new(repo: repo, name: "John Doe", email: "john.doe@gmail.com"),
          "joe.doe@gmail.com" => GitStats::GitData::Author.new(repo: repo, name: "Joe Doe", email: "joe.doe@gmail.com")
      }
    end

    it 'should parse git revlist output to commits hash' do
      GitStats::GitData::Command.should_receive(:new).with(
          repo, 'git rev-list --pretty=format:"%h|%at|%ai|%aE" HEAD | grep -v commit').and_return(
          double(:run => "e4412c3|1348603824|2012-09-25 22:10:24 +0200|john.doe@gmail.com
ce34874|1347482927|2012-09-12 22:48:47 +0200|joe.doe@gmail.com
5eab339|1345835073|2012-08-24 21:04:33 +0200|john.doe@gmail.com
"))

      repo.commits.should == {
          "e4412c3" => GitStats::GitData::Commit.new(
              repo: repo, hash: "e4412c3", stamp: "1348603824", date: DateTime.parse("2012-09-25 22:10:24 +0200"),
              author: repo.authors["john.doe@gmail.com"]),
          "ce34874" => GitStats::GitData::Commit.new(
              repo: repo, hash: "ce34874", stamp: "1347482927", date: DateTime.parse("2012-09-12 22:48:47 +0200"),
              author: repo.authors["joe.doe@gmail.com"]),
          "5eab339" => GitStats::GitData::Commit.new(
              repo: repo, hash: "5eab339", stamp: "1345835073", date: DateTime.parse("2012-08-24 21:04:33 +0200"),
              author: repo.authors["john.doe@gmail.com"])
      }
    end
  end
end