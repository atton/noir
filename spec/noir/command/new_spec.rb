require 'noir'
require 'spec_helper'

describe 'Noir::Command::New' do
  it 'is Command' do
    expect(Noir::Command::New.superclass).to eq(Noir::Base::Command)
  end
end
