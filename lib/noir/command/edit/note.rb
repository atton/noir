class Noir::Command::Edit::Note < Noir::Base::TerminalCommand
  @description = 'Create and edit for note. if you set negative number in argument, edit before note.'

  class << self

    def edit target
      system("vim #{target}")
    end

    def execute *args

      if args.size.zero?
        edit_today_note
      else
        edit_before_note args.first.to_i
      end
    end

    def edit_today_note
      search_pattern = '*' + Time.now.strftime(Noir::Command::New::Note::TimeFormat) + '*'
      today_files    = Dir.glob(search_pattern)
      target         = today_files.sort.last || Noir::Command::New::Note.create_new_note
      edit target
    end

    def edit_before_note diff
      notes = Dir.glob(Noir::Command::New::Note::FileNameGlob)
      if notes.size > diff.abs.succ
        edit notes[diff-1]
      else
        raise "Cannot find notes before #{diff} count."
      end
    end
  end
end
