require 'noir'
require 'spec_helper'

describe 'Noir::Command::Init::Zsh' do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Init::Zsh.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is output in execute' do
    expect{expect{Noir::Command::Init::Zsh.execute []}.to output.to_stdout}.to_not raise_exception
  end
end
