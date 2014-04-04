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
      expect{Noir::Base::TerminalCommand.execute}.to raise_error(RuntimeError, /^called raw/)
    end

    it 'raise exception in extended class not overrided' do
      expect{Hoge.execute}.to raise_error(RuntimeError, /^please override/)
    end

    it 'raise exception in extended class not overrided' do
      def Hoge.execute *args
        puts "hoge"
      end
      expect{Hoge.execute}.to output("hoge\n").to_stdout
    end
  end

end
