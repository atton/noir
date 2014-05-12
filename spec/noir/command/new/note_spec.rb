require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::Note' do
  it 'is TerminalCommand' do
    expect(Noir::Command::New::Note.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is call Noir::Command::New::createFile on exec' do
    allow(Noir::Command::New).to receive(:createFile)
    expect(Noir::Command::New).to receive(:createFile)
    expect{Noir::Command::New::Note.execute}.to output.to_stdout
  end
end
