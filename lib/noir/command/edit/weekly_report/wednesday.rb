class Noir::Command::Edit::WeeklyReport::Wednesday < Noir::Base::TerminalCommand
  @describe = 'edit weekly report separated by wednesday'

  class << self
    def execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Edit::WeeklyReport.edit_report :wednesday, week_diff
    end
  end
end
