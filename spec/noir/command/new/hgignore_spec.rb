require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::HgIgnore' do
  it 'is Command' do
    expect(Noir::Command::New::HgIgnore.superclass).to eq(Noir::Base::Command)
  end
end


