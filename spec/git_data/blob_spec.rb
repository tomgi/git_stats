require 'spec_helper'

describe GitStats::GitData::Blob do
  let(:repo) { double }
  let(:png_blob) { GitStats::GitData::Blob.new(filename: 'abc.png', hash: 'hash_png', repo: repo) }
  let(:txt_blob) { GitStats::GitData::Blob.new(filename: 'abc.txt', hash: 'hash_txt', repo: repo) }

  it 'should return 0 as lines count when files is binary' do
    png_blob.should_receive(:binary?).and_return true
    png_blob.lines_count.should == 0
  end

  it 'should return actual lines count when files is not binary' do
    txt_blob.should_receive(:binary?).and_return false
    repo.should_receive(:run).with("git cat-file blob hash_txt | wc -l").and_return 42
    txt_blob.lines_count.should == 42
  end

  it 'should invoke grep to check if file is binary' do
    repo.should_receive(:run).with("git cat-file blob hash_png | grep -m 1 '^'").and_return "Binary file matches"
    png_blob.should be_binary
  end

end