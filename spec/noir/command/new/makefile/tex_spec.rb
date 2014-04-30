require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::Makefile::Tex' do
  it 'is TerminalCommand' do
    expect(Noir::Command::New::Makefile::Tex.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is create Makefile by Noir::Command::New.createFile' do
    allow(Noir::Command::New).to receive(:createFile)
    expect(Noir::Command::New).to receive(:createFile).with('Makefile', anything)
    Noir::Command::New::Makefile::Tex.execute
  end
end

