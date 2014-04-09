class Noir::Command::Edit::WeeklyReport < Noir::Base::Command
  @description = 'edit weekly report'

  class << self
    def report_name day_of_week, week_diff=0
      return '20140401_20140407'
    end
  end
end
