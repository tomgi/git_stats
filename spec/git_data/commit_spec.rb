require 'spec_helper'

describe GitStats::GitData::Commit do
  let(:commit) { build(:commit, hash: 'abc') }

  describe 'git output parsing' do
    context 'parsing git ls-tree output' do
      before {
        commit.repo.should_receive(:run).with('git ls-tree -r abc').and_return("100644 blob 5ade7ad51a75ee7db4eb06cecd3918d38134087d	lib/git_stats/git_data/commit.rb
100644 blob db01e94677a8f72289848e507a52a43de2ea109a	lib/git_stats/git_data/repo.rb
100644 blob 1463eacb3ac9f95f21f360f1eb935a84a9ee0895	templates/activity.haml
100644 blob 31d8b960a67f195bdedaaf9e7aa70b2389f3f1a8	templates/assets/bootstrap/css/bootstrap.min.css
") }

      it 'should be parsed to files' do
        commit.files.should == [
            GitStats::GitData::Blob.new(repo: commit.repo, hash: "5ade7ad51a75ee7db4eb06cecd3918d38134087d", filename: "lib/git_stats/git_data/commit.rb"),
            GitStats::GitData::Blob.new(repo: commit.repo, hash: "db01e94677a8f72289848e507a52a43de2ea109a", filename: "lib/git_stats/git_data/repo.rb"),
            GitStats::GitData::Blob.new(repo: commit.repo, hash: "1463eacb3ac9f95f21f360f1eb935a84a9ee0895", filename: "templates/activity.haml"),
            GitStats::GitData::Blob.new(repo: commit.repo, hash: "31d8b960a67f195bdedaaf9e7aa70b2389f3f1a8", filename: "templates/assets/bootstrap/css/bootstrap.min.css"),
        ]
      end

      it 'should group files by extension' do
        commit.files_by_extension.should == {'.rb' => [
            GitStats::GitData::Blob.new(repo: commit.repo, hash: "5ade7ad51a75ee7db4eb06cecd3918d38134087d", filename: "lib/git_stats/git_data/commit.rb"),
            GitStats::GitData::Blob.new(repo: commit.repo, hash: "db01e94677a8f72289848e507a52a43de2ea109a", filename: "lib/git_stats/git_data/repo.rb")
        ], '.haml' => [
            GitStats::GitData::Blob.new(repo: commit.repo, hash: "1463eacb3ac9f95f21f360f1eb935a84a9ee0895", filename: "templates/activity.haml")
        ], '.css' => [
            GitStats::GitData::Blob.new(repo: commit.repo, hash: "31d8b960a67f195bdedaaf9e7aa70b2389f3f1a8", filename: "templates/assets/bootstrap/css/bootstrap.min.css")
        ]
        }
      end

      it 'should count lines by extension' do
        GitStats::GitData::Blob.should_receive(:new).and_return(
            double(lines_count: 40, extension: '.rb'),
            double(lines_count: 60, extension: '.rb'),
            double(lines_count: 0, extension: '.haml'),
            double(lines_count: 20, extension: '.css'),
        )
        commit.lines_by_extension.should == {'.rb' => 100, '.css' => 20}
      end
    end
  end
end