require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::Note' do
  it 'is TerminalCommand' do
    expect(Noir::Command::New::Note.superclass).to eq(Noir::Base::TerminalCommand)
  end
end
