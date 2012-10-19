require 'spec_helper'

describe GitStats::GitData::Repo do
  let(:repo) { build(:repo) }

  describe 'command observers' do
    context 'should be invoked after every command' do
      it 'should accept block' do
        command_runner = double('command_runner')
        repo = build(:repo, command_runner: command_runner)

        observer = double('observer')
        repo.add_command_observer { |command, result| observer.invoked(command, result) }
        command_runner.should_receive(:run).with(repo.path, 'aa').and_return('bb')
        observer.should_receive(:invoked).with('aa', 'bb')

        repo.run('aa')
      end

      it 'should accept Proc' do
        command_runner = double('command_runner')
        repo = build(:repo, command_runner: command_runner)

        observer = double('observer')
        repo.add_command_observer(observer)
        command_runner.should_receive(:run).with(repo.path, 'aa').and_return('bb')
        observer.should_receive(:call).with('aa', 'bb')

        repo.run('aa')
      end
    end
  end

end