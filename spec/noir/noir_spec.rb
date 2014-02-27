require 'spec_helper'
require 'noir'

describe Noir do

  it 'is can access Noir::VERSION' do
    expect(Noir.class_eval('Noir::VERSION.class')).to eq(String)
  end

  it 'is can access Noir::Base' do
    expect(Noir.class_eval('Noir::Base.class')).to eq(Module)
  end

  it 'is can access Noir::Base::Command' do
    expect(Noir.class_eval('Noir::Base::Command.class')).to eq(Class)
  end

  it 'is can access Noir::Base::TerminalCommand' do
    expect(Noir.class_eval('Noir::Base::TerminalCommand.class')).to eq(Class)
  end

end
