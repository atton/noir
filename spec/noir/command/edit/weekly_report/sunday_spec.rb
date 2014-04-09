require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit::WeeklyReport::Sunday' do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Edit::WeeklyReport::Sunday.superclass).to eq(Noir::Base::TerminalCommand)
  end
end
