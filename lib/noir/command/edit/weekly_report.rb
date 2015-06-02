class Noir::Command::Edit::WeeklyReport < Noir::Base::Command
  @description = 'edit weekly report'

  extend Noir::Util::Weekly
  TimeFormat = '%Y%m%d'

  def self.report_name separator_day_of_week, week_diff=0
    [begin_of_week_separeted(separator_day_of_week, week_diff).strftime(TimeFormat),
     end_of_week_separeted(separator_day_of_week, week_diff).strftime(TimeFormat)].join('_')
  end

  # main method
  def self.edit_report separator_day_of_week, week_diff=0
    system("vim #{report_name(separator_day_of_week, week_diff)}.txt")
  end
end

require 'noir/command/edit/weekly_report/monday'
require 'noir/command/edit/weekly_report/tuesday'
require 'noir/command/edit/weekly_report/wednesday'
require 'noir/command/edit/weekly_report/thursday'
require 'noir/command/edit/weekly_report/friday'
require 'noir/command/edit/weekly_report/saturday'
require 'noir/command/edit/weekly_report/sunday'
