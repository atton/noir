require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::HgIgnore::Agda' do
  it 'is TerminalCommand' do
    expect(Noir::Command::New::HgIgnore::Agda.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is create .hgignore by Noir::Command::New.createFile' do
    allow(Noir::Command::New).to receive(:createFile)
    expect(Noir::Command::New).to receive(:createFile).with('.hgignore', /agdai/)
    Noir::Command::New::HgIgnore::Agda.execute
  end
end

