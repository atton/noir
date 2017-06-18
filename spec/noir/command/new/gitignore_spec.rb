require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::GitIgnore' do
  it 'is TerminalCommand' do
    expect(Noir::Command::New::GitIgnore.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is create .gitignore' do
    allow(Noir::Command::New).to  receive(:createFile)
    expect(Noir::Command::New).to receive(:createFile).with('.gitignore', /.swp/)
    Noir::Command::New::GitIgnore.execute('vim')
  end

  describe '.ignore_texts_from_kinds' do
    it 'is raise error when arguments is empty' do
      expect{Noir::Command::New::GitIgnore.ignore_texts_from_kinds([])}.to raise_error(RuntimeError, /input/)
    end

    it 'is raise errors when arguments has invalid kinds' do
      expect{Noir::Command::New::GitIgnore.ignore_texts_from_kinds(['hoge'])}.to raise_error(RuntimeError, /Un/)
    end

    it 'is same text when valid a kind' do
      %w(Vim TeX).each do |k|
        valid_gitignore_text = Noir::Command::New::GitIgnore::GitIgnoreTexts.const_get(k)
        expect(Noir::Command::New::GitIgnore.ignore_texts_from_kinds([k])).to eq(valid_gitignore_text)
      end
    end

    it 'is support multi kinds' do
      kinds = %w(Vim TeX Vim)
      texts = (Noir::Command::New::GitIgnore.ignore_texts_from_kinds(kinds))
      kinds.each do |k|
        expect(texts).to include(Noir::Command::New::GitIgnore::GitIgnoreTexts.const_get(k))
      end
    end
  end
end

