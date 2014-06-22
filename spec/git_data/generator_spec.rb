# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GitStats::Generator do
  let(:repo_path) { 'repo_path' }
  let(:out_path) { 'out_path' }
  let(:generator) { GitStats::Generator.new(path: repo_path, out_path: out_path) }

  before { Dir.stub(:exists? => true) }

  it 'should raise exception if given repo path is not a git repository' do
    Dir.should_receive(:exists?).with("#{repo_path}/.git").and_return(false)
    expect { generator }.to raise_error(ArgumentError)
  end

  it 'should pass command observer to repo' do
    repo = double('repo')
    GitStats::GitData::Repo.should_receive(:new).with(path: repo_path, out_path: out_path).and_return(repo)
    
    observer = double('observer')
    repo.should_receive(:add_command_observer).with(observer)

    generator.add_command_observer observer
  end

  it 'should render all templates with view data for this repo' do
    repo = double('repo')
    GitStats::GitData::Repo.should_receive(:new).with(path: repo_path, out_path: out_path).and_return(repo)

    view_data = double('view_data')
    GitStats::StatsView::ViewData.should_receive(:new).with(repo).and_return(view_data)

    view = double('view')
    GitStats::StatsView::View.should_receive(:new).with(view_data, out_path).and_return(view)
    view.should_receive(:render_all)

    generator.render_all
  end
end
