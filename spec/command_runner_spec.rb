# -*- encoding : utf-8 -*-
#require 'spec_helper'
require './lib/git_stats/command_runner'
require 'shellwords'

RSpec.describe GitStats::CommandRunner do
  let(:runner) { build(:runner) }

  describe 'command runner' do
    it 'should not treat pipe inside single quotes as a stream operator' do
    	runner = GitStats::CommandRunner.new

    	command = "git rev-list --pretty=format:%h^|%at^|%ai^|%aE HEAD . | grep -v commit"
    	result = runner.run(".",command)
      expect(result).to match(/\+.+|.+|.+|.+/)
    end
  end
end