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

  it 'is support empty directory' do
    allow(Dir).to receive(:glob).with(anything).and_return([])
    expect(Noir::Command::New).to receive(:createFile)
    expect{Noir::Command::New::Note.execute}.to output(/^01_.*txt$/).to_stdout
  end

  it 'is support directory include few files' do
    allow(Dir).to receive(:glob).with(anything).and_return(10.times.to_a)
    expect(Noir::Command::New).to receive(:createFile)
    expect{Noir::Command::New::Note.execute}.to output(/^11_.*txt$/).to_stdout
  end

  it 'is support directory include over 100 files' do
    allow(Dir).to receive(:glob).with(anything).and_return(120.times.to_a)
    expect(Noir::Command::New).to receive(:createFile)
    expect{Noir::Command::New::Note.execute}.to output(/^121_.*txt$/).to_stdout
  end
end
