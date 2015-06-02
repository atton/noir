class Noir::Command::Summarize::Note::Weekly::Monday < Noir::Base::TerminalCommand
  @description = 'summarize notes weekly separated by monday'

  class << self
    def execute *args
      week_diff = args.first.to_i || 0
      Noir::Command::Summarize::Note::Weekly.summarize_by_week :monday, week_diff
    end
  end
end
