# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:repo) }

  describe 'commit range' do
    it 'should return HEAD by default' do
      repo.commit_range.should == 'HEAD'
    end

    it 'should return last_commit if it was given' do
      repo = build(:repo, last_commit_sha: 'abc')
      repo.commit_range.should == 'abc'
    end

    it 'should return range from first_commit to HEAD if first_commit was given' do
      repo = build(:repo, first_commit_sha: 'abc')
      repo.commit_range.should == 'abc..HEAD'
    end

    it 'should return range from first to last commit if both were given' do
      repo = build(:repo, first_commit_sha: 'abc', last_commit_sha: 'def')
      repo.commit_range.should == 'abc..def'
    end

    context 'git commands using range' do
      let(:repo) { build(:repo, first_commit_sha: 'abc', last_commit_sha: 'def') }

      it 'should affect authors command' do
        repo.should_receive(:run).with('git shortlog -se abc..def .').and_return("")
        repo.authors
      end

      it 'should affect commits command' do
        repo.should_receive(:run).with("git rev-list --pretty=format:'%h|%at|%ai|%aE' abc..def . | grep -v commit").and_return("")
        repo.commits
      end

      it 'should affect project version command' do
        repo.should_receive(:run).with('git rev-parse --short abc..def').and_return("")
        repo.project_version
      end
    end
  end

end
