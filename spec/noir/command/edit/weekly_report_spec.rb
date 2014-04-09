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

    it 'is raise invalid weekly separator' do
      expect{Noir::Command::Edit::WeeklyReport.report_name :unknown}.to raise_error
    end

    describe 'in no week diff' do
      it 'is return report_name by monday' do
        expect(Noir::Command::Edit::WeeklyReport.report_name :monday).to eq('20140331_20140406')
      end

      it 'is return report_name by tuesday' do
        expect(Noir::Command::Edit::WeeklyReport.report_name :tuesday).to eq('20140401_20140407')
      end

      it 'is return report_name by wednesday' do
        expect(Noir::Command::Edit::WeeklyReport.report_name :wednesday).to eq('20140326_20140401')
      end

      it 'is return report_name by thursday' do
        expect(Noir::Command::Edit::WeeklyReport.report_name :thursday).to eq('20140327_20140402')
      end

      it 'is return report_name by friday' do
        expect(Noir::Command::Edit::WeeklyReport.report_name :friday).to eq('20140328_20140403')
      end

      it 'is return report_name by saturday' do
        expect(Noir::Command::Edit::WeeklyReport.report_name :saturday).to eq('20140329_20140404')
      end

      it 'is return report_name by sunday' do
        expect(Noir::Command::Edit::WeeklyReport.report_name :sunday).to eq('20140330_20140405')
      end
    end

  end
end
