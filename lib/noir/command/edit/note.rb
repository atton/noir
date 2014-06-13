class Noir::Command::Edit::Note < Noir::Base::TerminalCommand
  @description = 'Create and edit for today note.'

  class << self

    def edit target
      system("vim #{target}")
    end

    def execute *args
      search_pattern = '*' + Time.now.strftime(Noir::Command::New::Note::TimeFormat) + '*'
      today_files    = Dir.glob(search_pattern)
      target         = today_files.sort.last || Noir::Command::New::Note.create_new_note
      edit target
    end
  end
end
