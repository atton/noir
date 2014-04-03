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

    it 'return matched commend name' do
      expect(Noir::Command::Completion.suggestions(['h'])).to include('hoge')
      expect(Noir::Command::Completion.suggestions(['h'])).to_not include('fuga')
    end
  end
end
