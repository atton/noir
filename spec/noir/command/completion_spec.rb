require 'noir'
require 'spec_helper'

describe 'Noir::Command::Completion' do
  it 'is Noir::Command::TerminalCommand' do
    expect(Noir::Command::Completion.class).to eq(Class)
  end

  describe 'suggestions' do
    before do
      stub_commands
    end

    it 'return all command from nil' do
      expect(Noir::Command::Completion.suggestions([])).to include('hoge')
      expect(Noir::Command::Completion.suggestions([])).to include('fuga')
      expect(Noir::Command::Completion.suggestions([])).to include('fugafuga')
    end

    it 'return nil from unmatched pattern' do
      expect(Noir::Command::Completion.suggestions(['piyo'])).to eq([])
    end

    it 'return matched command name' do
      list = ['h']
      expect(Noir::Command::Completion.suggestions(list)).to     include('hoge')
      expect(Noir::Command::Completion.suggestions(list)).to_not include('fuga')
      expect(Noir::Command::Completion.suggestions(list)).to_not include('fugafuga')
    end

    it 'return command list in sub command' do
      list = ['hoge']
      expect(Noir::Command::Completion.suggestions(list)).to     include('subcommand')
      expect(Noir::Command::Completion.suggestions(list)).to     include('subcommandtwo')
      expect(Noir::Command::Completion.suggestions(list)).to_not include('subsubcommand')
    end

    it 'return matched command name list in sub command' do
      list = ['hoge', 's']
      expect(Noir::Command::Completion.suggestions(list)).to     include('subcommand')
      expect(Noir::Command::Completion.suggestions(list)).to     include('subcommandtwo')
      expect(Noir::Command::Completion.suggestions(list)).to_not include('subsubcommand')
    end

    it 'return empty when not matched name in command' do
      list = ['hoge', 'p']
      expect(Noir::Command::Completion.suggestions(list)).to     eq([])
    end

    it 'return sub sub commands list in sub command' do
      list = ['hoge', 'subcommand']
      expect(Noir::Command::Completion.suggestions(list)).to     include('subsubcommand')
      expect(Noir::Command::Completion.suggestions(list)).to_not include('subcommand')
    end

    it 'return empty when not matched name in sub sub command' do
      list = ['hoge', 'subcommand', 's']
      expect(Noir::Command::Completion.suggestions(list)).to     include('subsubcommand')
      expect(Noir::Command::Completion.suggestions(list)).to_not include('subcommand')
    end

    it 'return empty when not matched name in sub command' do
      list = ['hoge', 'subcommand', 'aaaaaaa']
      expect(Noir::Command::Completion.suggestions(list)).to     eq([])
    end

    it 'return empty in terminal command' do
      list = ['hoge', 'subcommand', 'subsubcommand']
      expect(Noir::Command::Completion.suggestions(list)).to     eq([])
    end

    it 'return empty in terminal command' do
      list = ['fuga']
      expect(Noir::Command::Completion.suggestions(list)).to     eq([])
    end
  end
end
