require 'noir'
require 'spec_helper'

describe 'Noir::Command::Summarize::Note::Weekly' do
  include_context :dependencie_on_current_directory

  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Summarize::Note::Weekly.superclass).to eq(Noir::Base::Command)
  end

  describe '.summarize_by_week' do
    before do
      File.write('01_20140401.txt', 'hoge') # 2014/04/01(Tue)
      File.write('02_20140402.txt', 'fuga') # 2014/04/02(Wed)
      File.write('03_20140403.txt', 'piyo') # 2014/04/03(Thu)
    end

    it 'include texts in .txt file' do
      expect{Noir::Command::Summarize::Note::Weekly.summarize_by_week(:tuesday)}.to output(/hoge/).to_stdout
    end

    it 'include all texts in weekly range' do
      expect{Noir::Command::Summarize::Note::Weekly.summarize_by_week(:monday)}.to output(/hoge/).to_stdout
      expect{Noir::Command::Summarize::Note::Weekly.summarize_by_week(:monday)}.to output(/fuga/).to_stdout
      expect{Noir::Command::Summarize::Note::Weekly.summarize_by_week(:monday)}.to output(/piyo/).to_stdout
    end

    it 'not include texts without weekly range' do
      expect{Noir::Command::Summarize::Note::Weekly.summarize_by_week(:wednesday)}.to     output(/hoge/).to_stdout
      expect{Noir::Command::Summarize::Note::Weekly.summarize_by_week(:wednesday)}.not_to output(/fuga/).to_stdout
      expect{Noir::Command::Summarize::Note::Weekly.summarize_by_week(:wednesday)}.not_to output(/piyo/).to_stdout
    end
  end

  describe 'sub commands' do
    [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday].each do |day|
      it 'is inherited Noir::Base::TerminalCommand' do
        sub_command = Noir::Command::Summarize::Note::Weekly.const_get day.capitalize
        expect(sub_command.superclass).to eq(Noir::Base::TerminalCommand)
      end
    end
  end
end
