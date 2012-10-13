require 'spec_helper'

describe GitStats::GitData::Author do
  let(:repo) { GitStats::GitData::Repo.new(path: "repo_path") }
  let(:author) { GitStats::GitData::Author.new(repo: repo, name: "author1", email: "author1@gmail.com") }
  let(:other_author) { GitStats::GitData::Author.new(repo: repo, name: "author2", email: "author2@gmail.com") }
  let(:my_commits) { 10.times.map { |i| double("my_commit #{i}", :author => author) } }
  let(:other_commits) { 10.times.map { |i| double("other_commit #{i}", :author => other_author) } }

  before { repo.stub(:commits => my_commits + other_commits) }

  it 'commits should give repo commits filtered to this author' do
    author.commits.should == my_commits
  end


end