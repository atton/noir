require 'noir'
require 'spec_helper'

describe 'Noir::Command::Summarize::Note::Weekly' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Summarize::Note::Weekly.superclass).to eq(Noir::Base::Command)
  end
end
