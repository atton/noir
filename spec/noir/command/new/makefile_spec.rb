require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::Makefile' do
  it 'is Command' do
    expect(Noir::Command::New::Makefile.superclass).to eq(Noir::Base::Command)
  end
end


