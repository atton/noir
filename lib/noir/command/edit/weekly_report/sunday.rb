class Noir::Command::Edit::WeeklyReport::Sunday < Noir::Base::TerminalCommand
  @describe = 'edit weekly report separated by sunday'

  class << self
    def execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Edit::WeeklyReport.edit_report :sunday, week_diff
    end
  end
end
