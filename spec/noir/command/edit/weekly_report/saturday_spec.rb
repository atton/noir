require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit::WeeklyReport::Saturday' do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Edit::WeeklyReport::Saturday.superclass).to eq(Noir::Base::TerminalCommand)
  end
end
