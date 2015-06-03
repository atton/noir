require 'noir'
require 'spec_helper'

describe 'Noir::Command::Summarize::Note' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Summarize::Note.superclass).to eq(Noir::Base::Command)
  end
end

