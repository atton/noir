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

  describe 'supports empty directory' do
    it 'default digit = 2' do
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect(Noir::Command::New).to receive(:createFile)
      expect{Noir::Command::New::Note.execute}.to output(/^01_.*txt$/).to_stdout
    end

    it 'can set digit(1) using ENV' do
      allow(ENV).to receive(:[]).with('NOIR_NOTE_SERIAL_DIGIT').and_return('1')
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect(Noir::Command::New).to receive(:createFile)
      expect{Noir::Command::New::Note.execute}.to output(/^1_.*txt$/).to_stdout
    end

    it 'can set digit(3) using ENV' do
      allow(ENV).to receive(:[]).with('NOIR_NOTE_SERIAL_DIGIT').and_return('3')
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect(Noir::Command::New).to receive(:createFile)
      expect{Noir::Command::New::Note.execute}.to output(/^001_.*txt$/).to_stdout
    end
  end

  describe 'supports directory has' do
    it 'few files' do
      allow(Dir).to receive(:glob).with(anything).and_return(10.times.to_a)
      expect(Noir::Command::New).to receive(:createFile)
      expect{Noir::Command::New::Note.execute}.to output(/^11_.*txt$/).to_stdout
    end

    it 'few files with digit config' do
      allow(ENV).to receive(:[]).with('NOIR_NOTE_SERIAL_DIGIT').and_return('3')
      allow(Dir).to receive(:glob).with(anything).and_return(15.times.to_a)
      expect(Noir::Command::New).to receive(:createFile)
      expect{Noir::Command::New::Note.execute}.to output(/^016_.*txt$/).to_stdout
    end

    it 'over 100 files' do
      allow(Dir).to receive(:glob).with(anything).and_return(120.times.to_a)
      expect(Noir::Command::New).to receive(:createFile)
      expect{Noir::Command::New::Note.execute}.to output(/^121_.*txt$/).to_stdout
    end
  end

  describe 'has validation for NOIR_NOTE_SERIAL_DIGIT' do
    it 'if set 0, raise error' do
      allow(ENV).to receive(:[]).with('NOIR_NOTE_SERIAL_DIGIT').and_return('0')
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect{Noir::Command::New::Note.execute}.to raise_error(RuntimeError, /DIGIT.*0.*/)
    end

    it 'if set -1, raise error' do
      allow(ENV).to receive(:[]).with('NOIR_NOTE_SERIAL_DIGIT').and_return('-1')
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect{Noir::Command::New::Note.execute}.to raise_error(RuntimeError, /DIGIT.*-1.*/)
    end

    it 'if set 4, raise error' do
      allow(ENV).to receive(:[]).with('NOIR_NOTE_SERIAL_DIGIT').and_return('4')
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect{Noir::Command::New::Note.execute}.to raise_error(RuntimeError, /DIGIT.*4.*/)
    end

    it 'if set string, raise error' do
      allow(ENV).to receive(:[]).with('NOIR_NOTE_SERIAL_DIGIT').and_return('abc')
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect{Noir::Command::New::Note.execute}.to raise_error(RuntimeError, /DIGIT.*abc.*/)
    end

    it 'if raise error, not create file' do
      allow(ENV).to receive(:[]).with('NOIR_NOTE_SERIAL_DIGIT').and_return('hogehoge')
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect(Noir::Command::New).to_not receive(:createFile)
      expect{Noir::Command::New::Note.execute}.to raise_error(RuntimeError, /DIGIT.*hoge.*/)
    end
  end
end
