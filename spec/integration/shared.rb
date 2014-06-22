# -*- encoding : utf-8 -*-
require 'spec_helper'

shared_context "shared" do
  let(:repo) { build(:test_repo, last_commit_sha: '872955c') }
  let(:commit_dates) { [
      DateTime.parse('2012-10-19 10:44:34 +0200'),
      DateTime.parse('2012-10-19 10:46:10 +0200'),
      DateTime.parse('2012-10-19 10:46:56 +0200'),
      DateTime.parse('2012-10-19 10:47:35 +0200'),
      DateTime.parse('2012-10-20 12:49:02 +0200'),
      DateTime.parse('2012-10-21 12:49:02 +0200'),
      DateTime.parse('2012-10-21 12:54:02 +0200'),
      DateTime.parse('2012-10-21 13:20:00 +0200'),
      DateTime.parse('2012-10-24 15:49:02 +0200'),
      DateTime.parse('2012-10-26 17:05:25 +0200'),
  ] }
  let(:commit_dates_with_empty) {[
      Date.new(2012, 10, 19),
      Date.new(2012, 10, 20),
      Date.new(2012, 10, 21),
      Date.new(2012, 10, 22),
      Date.new(2012, 10, 23),
      Date.new(2012, 10, 24),
      Date.new(2012, 10, 25),
  ]}
  let(:tg_commit_dates) { [
      DateTime.parse('2012-10-19 10:44:34 +0200'),
      DateTime.parse('2012-10-19 10:46:10 +0200'),
      DateTime.parse('2012-10-19 10:46:56 +0200'),
      DateTime.parse('2012-10-19 10:47:35 +0200'),
      DateTime.parse('2012-10-20 12:49:02 +0200'),
      DateTime.parse('2012-10-21 12:49:02 +0200'),
      DateTime.parse('2012-10-21 13:20:00 +0200'),
      DateTime.parse('2012-10-26 17:05:25 +0200'),
  ] }
  let(:jd_commit_dates) { [
      DateTime.parse('2012-10-21 12:54:02 +0200'),
      DateTime.parse('2012-10-24 15:49:02 +0200'),
  ] }

  let(:expected_authors) { [
      build(:author, repo: repo, name: "Tomasz Gieniusz", email: "tomasz.gieniusz@gmail.com"),
      build(:author, repo: repo, name: "John Doe", email: "john.doe@gmail.com"),
  ] }
end


shared_context "tree_subdir_with_1_commit" do
  let(:repo) { build(:test_repo_tree, last_commit_sha: 'HEAD', tree_path: './subdir_with_1_commit') }
  let(:commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }
  let(:commit_dates_with_empty) {[
      Date.new(2014, 03, 21),
      Date.new(2014, 03, 21),
      Date.new(2014, 03, 21),
  ]}
  let(:tg_commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }
  let(:jd_commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }

  let(:expected_authors) { [
      build(:author, repo: repo, name: "Israel Revert", email: "israelrevert@gmail.com"),
  ] }
end

shared_context "tree_subdir_with_2_commit" do
  let(:repo) { build(:test_repo_tree, last_commit_sha: 'HEAD', tree_path: './subdir_with_2_commits') }
  let(:commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }
  let(:commit_dates_with_empty) {[
      Date.new(2014, 03, 21),
      Date.new(2014, 03, 21),
      Date.new(2014, 03, 21),
  ]}
  let(:tg_commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }
  let(:jd_commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }

  let(:expected_authors) { [
      build(:author, repo: repo, name: "Israel Revert", email: "israelrevert@gmail.com"),
  ] }
end



# 5fd0f5e|1395407567|2014-03-21 14:12:47 +0100|israelrevert@gmail.com
# 435e0ef|1395407543|2014-03-21 14:12:23 +0100|israelrevert@gmail.com
# 10d1814|1395407506|2014-03-21 14:11:46 +0100|israelrevert@gmail.com

shared_context "tree" do
  let(:repo) { build(:test_repo_tree, last_commit_sha: 'HEAD') }
  let(:commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }
  let(:commit_dates_with_empty) {[
      Date.new(2014, 03, 21),
      Date.new(2014, 03, 21),
      Date.new(2014, 03, 21),
  ]}
  let(:tg_commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }
  let(:jd_commit_dates) { [
      DateTime.parse('2014-03-21 14:11:46 +0100'),
      DateTime.parse('2014-03-21 14:12:23 +0100'),
      DateTime.parse('2014-03-21 14:12:47 +0100'),
  ] }

  let(:expected_authors) { [
      build(:author, repo: repo, name: "Israel Revert", email: "israelrevert@gmail.com"),
  ] }
end
