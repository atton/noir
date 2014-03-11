require 'noir'
require 'spec_helper'

describe 'Noir::Command' do
  it 'is Module' do
    expect(Noir::Command.class).to eq(Module)
  end
end
