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

    it 'is edit before note if set negative number' do
      allow(Dir).to receive(:glob).with(anything).and_return([1, 2, 3, 4, 5])
      expect(Noir::Command::Edit::Note).to receive(:edit).with(4)
      Noir::Command::Edit::Note.execute '-1'
    end

    it 'is edit before note if set negative number in range' do
      allow(Dir).to receive(:glob).with(anything).and_return([1, 2, 3, 4, 5])
      expect(Noir::Command::Edit::Note).to receive(:edit).with(2)
      Noir::Command::Edit::Note.execute '-3'
    end

    it 'returns error if set negative number out of range' do
      allow(Dir).to receive(:glob).with(anything).and_return([1, 2, 3, 4, 5])
      expect(Noir::Command::Edit::Note).to_not receive(:edit)
      [-4,-5,-6].each do |n|
        expect{Noir::Command::Edit::Note.execute(n.to_s)}.to raise_error(/Cannot/)
      end
    end
  end

end

