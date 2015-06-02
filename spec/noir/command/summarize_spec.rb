require 'noir'
require 'spec_helper'

describe 'Noir::Command::Summarize' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Summarize.superclass).to eq(Noir::Base::Command)
  end
end


