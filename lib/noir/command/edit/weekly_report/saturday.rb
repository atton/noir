class Noir::Command::Edit::WeeklyReport::Saturday < Noir::Base::TerminalCommand
  @describe = 'edit weekly report separated by saturday'

  class << self
    def execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Edit::WeeklyReport.edit_report :saturday, week_diff
    end
  end
end
