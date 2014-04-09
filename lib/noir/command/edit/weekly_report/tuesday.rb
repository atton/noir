class Noir::Command::Edit::WeeklyReport::Tuesday < Noir::Base::TerminalCommand
  @describe = 'edit weekly report separated by tuesday'

  class << self
    def execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Edit::WeeklyReport.edit_report :tuesday, week_diff
    end
  end
end
