# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GitStats::CLI do
  let(:repo_path) { 'repo_path' }
  let(:out_path) { 'out_path' }

  it 'should invoke generator with console arguments given' do
    generator = double('generator')
    GitStats::Generator.should_receive(:new).with(repo_path, out_path).and_return(generator)
    generator.should_receive(:render_all)

    subject.start(repo_path, out_path)
  end

  it 'should raise error when 2 arguments are not given' do
    expect { subject.start("only one argument") }.to raise_error
    expect { subject.start("too", "much", "arguments") }.to raise_error
  end
end
