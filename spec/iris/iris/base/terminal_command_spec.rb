require 'iris'
require 'spec_helper'

describe 'Iris::Base::TerminalCommand' do

  it 'is class' do
    expect(Iris::Base::TerminalCommand.class).to eq(Class)
  end

  it 'is inherited Iris::Base::Command' do
    expect(Iris::Base::TerminalCommand.ancestors).to include(Iris::Base::Command)
  end

  describe '.execute' do
    it 'raise exception when not overrided' do
      expect{Iris::Base::TerminalCommand.execute}.to raise_error(RuntimeError)
    end

    it 'not raise exception in extended class' do
      class Fuga < Iris::Base::TerminalCommand
      end

      expect{Fuga.execute}.not_to raise_error
    end

    it 'is support varibale length arguments' do
      class Fuga < Iris::Base::TerminalCommand
      end

      expect{Fuga.execute 0}.not_to raise_error
      expect{Fuga.execute 0, 0}.not_to raise_error
      expect{Fuga.execute 0, 0, 0}.not_to raise_error
      expect{Fuga.execute 0, 0, 0, 0}.not_to raise_error
      expect{Fuga.execute 0, 0, 0, 0, 0}.not_to raise_error
    end
  end

end
