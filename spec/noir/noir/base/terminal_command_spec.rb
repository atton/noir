require 'noir'
require 'spec_helper'

describe 'Noir::Base::TerminalCommand' do

  it 'is class' do
    expect(Noir::Base::TerminalCommand.class).to eq(Class)
  end

  it 'is inherited Noir::Base::Command' do
    expect(Noir::Base::TerminalCommand.ancestors).to include(Noir::Base::Command)
  end

  describe '.execute' do
    before { stub_const('Hoge', Class.new(Noir::Base::TerminalCommand)) }

    it 'raise exception when not overrided' do
      expect{Noir::Base::TerminalCommand.execute}.to raise_error(RuntimeError)
    end

    it 'not raise exception in extended class' do
      expect{Hoge.execute}.not_to raise_error
    end

    it 'is support varibale length arguments' do
      expect{Hoge.execute 0}.not_to raise_error
      expect{Hoge.execute 0, 0}.not_to raise_error
      expect{Hoge.execute 0, 0, 0}.not_to raise_error
      expect{Hoge.execute 0, 0, 0, 0}.not_to raise_error
      expect{Hoge.execute 0, 0, 0, 0, 0}.not_to raise_error
    end
  end

end
