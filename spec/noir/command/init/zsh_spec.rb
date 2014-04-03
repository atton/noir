require 'noir'
require 'spec_helper'

describe 'Noir::Command::Init::Zsh' do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Init::Zsh.superclass).to eq(Noir::Base::TerminalCommand)
  end
end
