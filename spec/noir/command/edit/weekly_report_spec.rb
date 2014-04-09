require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit::WeeklyReport' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Edit::WeeklyReport.superclass).to eq(Noir::Base::Command)
  end

  describe '.report_name' do
    before do
      class Time
        def self.now
          Time.new(2014, 4, 1)  # test date is 2014/04/01
        end
      end
    end

    it 'is return report_name by mon' do
      expect(Noir::Command::Edit::WeeklyReport.report_name :monday).to eq('20140331_20140406')
    end

    it 'is return report_name by tuesday' do
      expect(Noir::Command::Edit::WeeklyReport.report_name :tuesday).to eq('20140401_20140407')
    end
  end
end
