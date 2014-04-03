require 'noir'
require 'spec_helper'

describe 'Noir::Executer' do

  # define command for tests
  before do
    stub_commands
  end

  it 'is class' do
    expect(Noir::Executer.class).to eq(Class)
  end

  describe 'command_from_argv' do

    describe 'in undefined argv' do
      before do
        stub_const('ARGV', [])
        stub_const('Noir::Command::Help', Class.new(Noir::Base::Command))
      end

      it 'return Help' do
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Help)
      end
    end

    describe 'in defined argv' do

      it 'return command' do
        stub_const 'ARGV', ['hoge']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge)
      end

      it 'return command if has other arguments' do
        stub_const 'ARGV', ['hoge', 'aaa']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge)
      end

      it 'return command if has sub non command' do
        stub_const 'ARGV', ['hoge', 'SubNonCommand']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge)
      end

      it 'return sub command' do
        stub_const 'ARGV', ['hoge', 'subcommand']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge::SubCommand)
      end

      it 'return sub command if has other arguments' do
        stub_const 'ARGV', ['hoge', 'subcommand', 'aaa']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge::SubCommand)
      end

      it 'return sub command if has sub non command' do
        stub_const 'ARGV', ['hoge', 'SubCommand', 'SubSubNonCommand']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge::SubCommand)
      end

      it 'return sub sub command' do
        stub_const 'ARGV', ['hoge', 'subcommand', 'subsubcommand']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge::SubCommand::SubSubCommand)
      end

      it 'return sub sub command if has other arguments' do
        stub_const 'ARGV', ['hoge', 'subcommand', 'subsubcommand', 'aaa']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge::SubCommand::SubSubCommand)
      end

      it 'return terminal command' do
        stub_const 'ARGV', ['fuga']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Fuga)
      end

      it 'return terminal command if has other arguments' do
        stub_const 'ARGV', ['fuga', 'aaa']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Fuga)
      end

    end
  end

  describe 'args_from_argv' do

    describe 'in undefined ARGV' do
      before { stub_const('ARGV', []) }

      it 'return []' do
        expect(Noir::Executer.args_from_argv).to eq([])
      end
    end

    describe 'in defined argv' do

      it 'return [] if only command' do
        stub_const 'ARGV', ['hoge']
        expect(Noir::Executer.args_from_argv).to eq([])
      end

      it 'return single arg if argv is comamnd + arg' do
        stub_const 'ARGV', ['hoge', 'aaa']
        expect(Noir::Executer.args_from_argv).to eq(['aaa'])
      end

      it 'return multi arg if argv is comamnd + args' do
        stub_const 'ARGV', ['hoge', 'aaa', 'bbb']
        expect(Noir::Executer.args_from_argv).to eq(['aaa', 'bbb'])
      end

      it 'return single arg if argv is command +  sub non command' do
        stub_const 'ARGV', ['hoge', 'SubNonCommand']
        expect(Noir::Executer.args_from_argv).to eq(['SubNonCommand'])
      end

      it 'return [] if argv is command + sub command' do
        stub_const 'ARGV', ['hoge', 'subcommand']
        expect(Noir::Executer.args_from_argv).to eq([])
      end

      it 'return single arg if argv is command + sub command + arg' do
        stub_const 'ARGV', ['hoge', 'subcommand', 'aaa']
        expect(Noir::Executer.args_from_argv).to eq(['aaa'])
      end

      it 'return multi arg if argv is command + sub command + args' do
        stub_const 'ARGV', ['hoge', 'subcommand', 'aaa', 'bbb']
        expect(Noir::Executer.args_from_argv).to eq(['aaa', 'bbb'])
      end

      it 'return single arg if argv is command + sub command + subsubnoncommand' do
        stub_const 'ARGV', ['hoge', 'SubCommand', 'SubSubNonCommand']
        expect(Noir::Executer.args_from_argv).to eq(['SubSubNonCommand'])
      end

      it 'return [] if argv is command + sub command + sub sub command' do
        stub_const 'ARGV', ['hoge', 'subcommand', 'subsubcommand']
        expect(Noir::Executer.args_from_argv).to eq([])
      end

      it 'return single arg, if argv is command + sub command + sub sub command + arg' do
        stub_const 'ARGV', ['hoge', 'subcommand', 'subsubcommand', 'aaa']
        expect(Noir::Executer.args_from_argv).to eq(['aaa'])
      end

      it 'return multi arg, if argv is command + sub command + sub sub command + args' do
        stub_const 'ARGV', ['hoge', 'subcommand', 'subsubcommand', 'aaa', 'bbb']
        expect(Noir::Executer.args_from_argv).to eq(['aaa', 'bbb'])
      end

      it 'return [] if argv is terminal command' do
        stub_const 'ARGV', ['fuga']
        expect(Noir::Executer.args_from_argv).to eq([])
      end

      it 'return single arg, if argv is terminal command + arg' do
        stub_const 'ARGV', ['fuga', 'aaa']
        expect(Noir::Executer.args_from_argv).to eq(['aaa'])
      end

      it 'return single arg, if argv is terminal command + args' do
        stub_const 'ARGV', ['fuga', 'aaa', 'bbb']
        expect(Noir::Executer.args_from_argv).to eq(['aaa', 'bbb'])
      end

    end
  end
end
