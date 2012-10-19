require 'spec_helper'

describe GitStats::GitData::Activity do
  let(:repo) { build(:test_repo, last_commit_hash: '45677ee') }

  let(:tg) { repo.authors.by_email('tomasz.gieniusz@gmail.com') }
  let(:jd) { repo.authors.by_email('john.doe@gmail.com') }

  it 'should filter commits to author' do
    tg.commits.map(&:hash).should =~ %w(b3b4f81 d60b5ec ab47ef8 2c11f5e c87ecf9 b621a5d 4e7d0e9 45677ee)
    jd.commits.map(&:hash).should =~ %w(fd66657 81e8bef)
  end
end