require 'spec_helper'

describe GitStats::GitData::Author do
  let(:my_commits) { Hash[10.times.map { |i| ["my #{i}", double("my_commit #{i}", :author => author)] }] }
  let(:other_commits) { Hash[10.times.map { |i| ["other #{i}", double("other_commit #{i}", :author => 42)] }] }
  let(:repo) { double("repo") }
  let(:author) { GitStats::GitData::Author.new(repo: repo) }
  before { repo.stub(:commits => my_commits.merge(other_commits)) }

  it 'commits should give repo commits filtered to this author' do
    author.commits.should == my_commits
  end


end