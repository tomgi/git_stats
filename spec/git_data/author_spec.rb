require 'spec_helper'

describe GitStats::GitData::Author do
  let(:repo) { build(:repo) }
  let(:author) { build(:author, repo: repo) }
  let(:other_author) { build(:author, repo: repo) }
  let(:my_commits) { 10.times.map { |i| double("my_commit #{i}", :author => author) } }
  let(:other_commits) { 10.times.map { |i| double("other_commit #{i}", :author => other_author) } }

  before { repo.stub(:commits => my_commits + other_commits) }

  it 'commits should give repo commits filtered to this author' do
    author.commits.should == my_commits
  end


end