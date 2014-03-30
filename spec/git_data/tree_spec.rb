# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GitStats::GitData::Tree do
  let(:repo) { build(:test_repo_tree, tree_path: '.') }
  let(:repo_tree) { build(:test_repo_tree, tree_path: './subdir_with_1_commit') }
  let(:tree) { build(:tree, repo: repo_tree, relative_path: './subdir_with_1_commit') }

  describe 'tree git output parsing' do
    it 'should return . by default' do
      repo.tree.should == GitStats::GitData::Tree.new(repo: repo, relative_path: '.')
    end

    it 'should return relative_path given by parameter' do
      repo_tree.tree.should == GitStats::GitData::Tree.new(repo: repo, relative_path: './subdir_with_1_commit')
      repo_tree.tree.relative_path.should == './subdir_with_1_commit'
      tree.relative_path.should == './subdir_with_1_commit'
    end

    context 'invoking authors command' do
      before do
        repo_tree.should_receive(:run).with('git shortlog -se HEAD ./subdir_with_1_commit').and_return("	3	Israel Revert <israelrevert@gmail.com>
")
      end

      it 'should parse git shortlog output to authors hash' do
        repo_tree.authors.should == [ build(:author, repo: repo_tree, name: "Israel Revert", email:"israelrevert@gmail.com") ]
      end

      it 'should parse git revlist output to date sorted commits array' do
        repo_tree.should_receive(:run).
          with("git rev-list --pretty=format:'%h|%at|%ai|%aE' HEAD ./subdir_with_1_commit | grep -v commit").
          and_return("10d1814|1395407506|2014-03-21 14:11:46 +0100|israelrevert@gmail.com")
        repo_tree.commits.should ==
          [ GitStats::GitData::Commit.new( repo: repo, sha: "10d1814", stamp: "1395407506",
                                           date: DateTime.parse("2014-03-21 14:11:46 +0100"),
                                           author: repo.authors.by_email("israelrevert@gmail.com"))]
      end
    end
  end
end
