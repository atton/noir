require 'noir'
require 'spec_helper'

describe Noir::Command::Summarize::Note::Weekly::Monday do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Summarize::Note::Weekly::Monday.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is output summary to stdout' do
    expect{Noir::Command::Summarize::Note::Weekly::Monday.execute}.to output.to_stdout
  end
end
