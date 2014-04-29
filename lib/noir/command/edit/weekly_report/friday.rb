class Noir::Command::Edit::WeeklyReport::Friday < Noir::Base::TerminalCommand
  @description = 'edit weekly report separated by friday'

  class << self
    def execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Edit::WeeklyReport.edit_report :friday, week_diff
    end
  end
end
