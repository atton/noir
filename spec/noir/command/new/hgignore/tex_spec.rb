require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::HgIgnore::Tex' do
  it 'is TerminalCommand' do
    expect(Noir::Command::New::HgIgnore::Tex.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is create .hgignore by Noir::Command::New.createFile' do
    allow(Noir::Command::New).to receive(:createFile)
    expect(Noir::Command::New).to receive(:createFile).with('.hgignore', anything)
    Noir::Command::New::HgIgnore::Tex.execute
  end
end
