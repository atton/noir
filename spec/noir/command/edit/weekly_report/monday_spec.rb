require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit::WeeklyReport::Monday' do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Edit::WeeklyReport::Monday.superclass).to eq(Noir::Base::TerminalCommand)
  end
end
