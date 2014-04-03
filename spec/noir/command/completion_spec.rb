require 'noir'
require 'spec_helper'

describe 'Noir::Command::Completion' do
  it 'is Noir::Command::TerminalCommand' do
    expect(Noir::Command::Completion.class).to eq(Class)
  end

  describe 'exec' do
    before do
      stub_commands
    end

    it 'return all command from nil' do
        expect(Noir::Command::Completion.execute([])).to eq(['hoge', 'fuga'])
    end
  end
end
