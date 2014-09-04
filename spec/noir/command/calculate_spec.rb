require 'noir'
require 'spec_helper'

describe 'Noir::Command::Calculate' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Calculate.superclass).to eq(Noir::Base::Command)
  end
end


