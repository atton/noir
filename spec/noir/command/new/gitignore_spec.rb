require 'noir'
require 'spec_helper'

describe 'Noir::Command::New::GitIgnore' do
  it 'is Command' do
    expect(Noir::Command::New::GitIgnore.superclass).to eq(Noir::Base::Command)
  end
end

