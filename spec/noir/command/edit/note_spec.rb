require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit::Note' do
  it 'is inherited Noir::Command::TerminalCommand' do
    expect(Noir::Command::Edit::Note.superclass).to eq(Noir::Base::TerminalCommand)
  end

  describe '.execute' do
    it 'is create new note if not created today note' do
      allow(Dir).to receive(:glob).with(anything).and_return([])
      expect(Noir::Command::New::Note).to receive(:create_new_note)
      expect(Noir::Command::Edit::Note).to receive(:edit).with(anything)
      Noir::Command::Edit::Note.execute
    end

    it 'is not create new note if not created today note' do
      allow(Dir).to receive(:glob).with(anything).and_return(['hoge'])
      expect(Noir::Command::Edit::Note).to receive(:edit).with('hoge')
      Noir::Command::Edit::Note.execute
    end
  end

end

