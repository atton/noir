require 'noir'
require 'spec_helper'

describe 'Noir::Executer' do

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
      before do
        stub_const('Noir::Command::Hoge'                               , Class.new(Noir::Base::Command))
        stub_const('Noir::Command::Hoge::SubCommand'                   , Class.new(Noir::Base::Command))
        stub_const('Noir::Command::Hoge::SubCommand::SubSubCommand'    , Class.new(Noir::Base::Command))
        stub_const('Noir::Command::Hoge::SubCommand::SubSubNonCommand' , Class.new)
        stub_const('Noir::Command::Hoge::SubCommandTwo'                , Class.new(Noir::Base::Command))
        stub_const('Noir::Command::Hoge::SubNonCommand'                , Class.new)
        stub_const('Noir::Command::Fuga'                               , Class.new(Noir::Base::TerminalCommand))

=begin
        # stub_const is this structure
        module Noir::Command
          class Hoge < Noir::Base::Command
            class SubCommand < Noir::Base::Command
              class SubSubCommand < Noir::Base::Command
              end
              class SubSubNonCommand
              end
            end
            class SubCommandTwo < Noir::Base::Command
            end

            class SubNonCommand
            end
          end
          class Fuga < Noir::Base::TerminalCommand
          end
        end
=end
      end

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
end
