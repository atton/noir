require 'noir'
require 'spec_helper'

describe 'Noir::Command::Init' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Init.superclass).to eq(Noir::Base::Command)
  end
end
