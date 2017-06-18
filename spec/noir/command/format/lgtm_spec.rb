require 'noir'
require 'spec_helper'

describe 'Noir::Command::Format::LGTM' do
  it 'is inherited Noir::Base::Terminalcommand' do
    expect(Noir::Command::Format::LGTM.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is raise exception when argument is empty' do
    expect{Noir::Command::Format::LGTM.execute}.to raise_error(RuntimeError, /URL Missing/)
  end

  it 'outputs Markdown strging from valid URL' do
    url = 'http://www.google.com/'
    expect{ Noir::Command::Format::LGTM.execute(url) }.to output(/LGTM/).to_stdout
  end

  it 'is output message, if link is not valid' do
    expect{ Noir::Command::Format::LGTM.execute('hoge') }.to output(/is not URL/).to_stdout
  end
end
