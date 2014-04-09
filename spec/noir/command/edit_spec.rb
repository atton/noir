require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Edit.superclass).to eq(Noir::Base::Command)
  end
end

