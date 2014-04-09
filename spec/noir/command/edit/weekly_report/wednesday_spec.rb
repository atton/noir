require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit::WeeklyReport::Wednesday' do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Edit::WeeklyReport::Wednesday.superclass).to eq(Noir::Base::TerminalCommand)
  end
end
