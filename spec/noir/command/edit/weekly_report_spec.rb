require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit::WeeklyReport' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Edit::WeeklyReport.superclass).to eq(Noir::Base::Command)
  end
end
