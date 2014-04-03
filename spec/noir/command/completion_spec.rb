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
    end

    it 'return nil from unmatched pattern' do
      expect(Noir::Command::Completion.suggestions(['piyo'])).to eq([])
    end

    it 'return matched command name' do
      list = ['h']
      expect(Noir::Command::Completion.suggestions(list)).to     include('hoge')
      expect(Noir::Command::Completion.suggestions(list)).to_not include('fuga')
    end

    it 'return command list in sub command' do
      list = ['hoge']
      expect(Noir::Command::Completion.suggestions(list)).to     include('subcommand')
      expect(Noir::Command::Completion.suggestions(list)).to     include('subcommandtwo')
      expect(Noir::Command::Completion.suggestions(list)).to_not include('subsubcommand')
    end

  end
end
