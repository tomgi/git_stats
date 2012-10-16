require 'spec_helper'

describe GitStats::GitData::Commit do
  let(:commit) { build(:commit) }

  describe 'git output parsing' do
    it 'should parse git ls-tree output' do
      GitStats::GitData::Command.any_instance.should_receive(:run_in_repo).and_return("100644 blob 5ade7ad51a75ee7db4eb06cecd3918d38134087d	lib/git_stats/git_data/commit.rb
100644 blob db01e94677a8f72289848e507a52a43de2ea109a	lib/git_stats/git_data/repo.rb
")

      commit.files.should == [
          GitStats::GitData::Blob.new(repo: commit.repo, hash: "5ade7ad51a75ee7db4eb06cecd3918d38134087d", filename: "lib/git_stats/git_data/commit.rb"),
          GitStats::GitData::Blob.new(repo: commit.repo, hash: "db01e94677a8f72289848e507a52a43de2ea109a", filename: "lib/git_stats/git_data/repo.rb"),
      ]
    end
  end
end