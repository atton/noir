class Noir::Command::Edit::WeeklyReport::Thursday < Noir::Base::TerminalCommand
  @describe = 'edit weekly report separated by thursday'

  class << self
    def execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Edit::WeeklyReport.edit_report :thursday, week_diff
    end
  end
end
