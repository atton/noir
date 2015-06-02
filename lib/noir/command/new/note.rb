class Noir::Command::New::Note < Noir::Base::TerminalCommand
  @description = 'Create empty txt. filename format is <serial-no>_<date>.txt'

  TimeFormat   = '%Y%m%d'
  FileNameGlob = '[0-9]*_????????.txt'

  class << self

    def create_new_note
      note_num  = Dir.glob(FileNameGlob).size + 1
      note_name = format("%02d", note_num) + '_' + Time.now.strftime(TimeFormat) + '.txt'
      Noir::Command::New.createFile note_name
      return note_name
    end

    def execute *args
      puts create_new_note
    end

  end
end
