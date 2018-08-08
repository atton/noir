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
    system("#{Noir::Command::Edit.editor} #{report_name(separator_day_of_week, week_diff)}.txt")
  end
end

[:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday].each do |day|
  clazz = Class.new(Noir::Base::TerminalCommand)
  clazz.class_eval do
    @description = "edit weekly report separated by #{day}"
    @day_of_week = day
  end
  clazz.class_eval do
    def self.execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Edit::WeeklyReport.edit_report @day_of_week, week_diff
    end
  end
  Noir::Command::Edit::WeeklyReport.const_set(day.capitalize, clazz)
end
