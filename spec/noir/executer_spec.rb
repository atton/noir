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

      it 'return Noir::Command' do
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command)
      end
    end # in undefined ARGV

    describe 'in defined ARGV' do

      it 'return command' do
        stub_const 'ARGV', ['hoge']
        expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge)
      end

      it 'return prefix duplicated command' do
        stub_const 'ARGV', ['fuga']
        expect(Noir::Executer.command_from_argv).to     eq(Noir::Command::Fuga)
        expect(Noir::Executer.command_from_argv).not_to eq(Noir::Command::FugaFuga)
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

      describe 'abbrev command' do

        it 'return only matched command' do
          stub_const 'ARGV', ['ho']
          expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge)
        end

        it 'raise exception matched one more' do
          stub_const 'ARGV', ['h']
          expect{Noir::Executer.command_from_argv}.to raise_error(RuntimeError)
        end

        it 'support multi command abbrev' do
          stub_const 'ARGV', ['ho', 'subcommandt']
          expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge::SubCommandTwo)
        end

        it 'support multi command abbrev with args' do
          stub_const 'ARGV', ['ho', 'subcommandt', 'piyo']
          expect(Noir::Executer.command_from_argv).to eq(Noir::Command::Hoge::SubCommandTwo)
        end

      end
    end # in defined ARGV
  end # command_from_argv

  describe 'find_command' do
    it 'return perfect matched command' do
      expect(Noir::Executer.find_command ['Noir', 'Command'], 'hoge').to eq('Hoge')
    end

    it 'raise exeption in ambiguous match' do
      expect{Noir::Executer.find_command(['Noir', 'Command'], 'f')}.to raise_error(RuntimeError)
    end
  end # find_command

  describe 'args_from_argv' do

    describe 'in undefined ARGV' do
      before { stub_const('ARGV', []) }

      it 'return []' do
        expect(Noir::Executer.args_from_argv).to eq([])
      end
    end # in undefined ARGV

    describe 'in defined ARGV' do

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

    end # in defined argv

  end # args_from_argv

  describe 'execute' do
    let(:mock_command) { double('Noir::Base::Command') }

    before do
      stub_const 'Noir::Executer', Noir::Executer
      allow(Noir::Executer).to receive(:command_from_argv).and_return(mock_command)

      allow(mock_command).to receive(:execute).and_return(:call_execute)
      allow(mock_command).to receive(:description).and_return(:call_description)
    end

    it 'not has help flag. execute command.execute' do
      stub_const 'ARGV', []
      expect(Noir::Executer.execute).to eq(:call_execute)
    end

    it 'has help option. execute command.describe' do
      stub_const 'ARGV', ['-h']
      expect(Noir::Executer.execute).to eq(:call_description)
    end

    it 'has log help option. execute command.describe' do
      stub_const 'ARGV', ['--help']
      expect(Noir::Executer.execute).to eq(:call_description)
    end
  end # execute
end
