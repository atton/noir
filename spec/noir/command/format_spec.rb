require 'noir'
require 'spec_helper'

describe 'Noir::Command::Format' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Format.superclass).to eq(Noir::Base::Command)
  end
end


