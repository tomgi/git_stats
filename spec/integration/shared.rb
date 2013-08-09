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
