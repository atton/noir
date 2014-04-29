require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::GitIgnore::Vim' do
  it 'is TerminalCommand' do
    expect(Noir::Command::New::GitIgnore::Vim.superclass).to eq(Noir::Base::TerminalCommand)
  end
end


