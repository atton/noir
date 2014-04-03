require 'noir'
require 'spec_helper'

describe 'Noir::Command::Completion' do
  it 'is Noir::Command::TerminalCommand' do
    expect(Noir::Command::Completion.class).to eq(Class)
  end
end
