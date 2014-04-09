require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit::WeeklyReport::Friday' do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Edit::WeeklyReport::Friday.superclass).to eq(Noir::Base::TerminalCommand)
  end
end
