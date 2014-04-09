class Noir::Command::Edit::WeeklyReport::Monday < Noir::Base::TerminalCommand
  @describe = 'edit weekly report separated by monday'

  class << self
    def execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Edit::WeeklyReport.edit_report :monday, week_diff
    end
  end
end
