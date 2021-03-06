require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::HgIgnore' do
  it 'is TerminalCommand' do
    expect(Noir::Command::New::HgIgnore.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is create .hgignore' do
    allow(Noir::Command::New).to  receive(:createFile)
    expect(Noir::Command::New).to receive(:createFile).with('.hgignore', /glob/)
    Noir::Command::New::HgIgnore.execute('vim')
  end

  it 'is raise when arguments is empty by .ignore_texts_from_kinds' do
    expect{Noir::Command::New::HgIgnore.execute}.to raise_error(RuntimeError, /input/)
  end

  it 'is raise when arguments includes invalid kinds' do
    expect{Noir::Command::New::HgIgnore.execute('hoge')}.to raise_error(RuntimeError, /Unsupported kinds/)
  end


  it 'use texts is generated by GitIgnore.ignore_texts_from_kinds' do
    allow(Noir::Command::New::GitIgnore).to  receive(:ignore_texts_from_kinds)
    expect(Noir::Command::New::GitIgnore).to receive(:ignore_texts_from_kinds).with(['tex']).and_return('')

    allow(Noir::Command::New).to  receive(:createFile)
    expect(Noir::Command::New).to receive(:createFile).with('.hgignore', /glob/)
    Noir::Command::New::HgIgnore.execute('tex')
  end
end


