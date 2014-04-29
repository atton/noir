require 'date'

class Noir::Command::New::Note < Noir::Base::TerminalCommand
  @description = 'create empty txt. filename format is <serial-no>_<date>.txt'

  class << self

    def execute *args
      note_num  = Dir.glob('[0-9]*_????????.txt').size + 1
      note_name = format("%02d", note_num) + '_' + Time.now.strftime('%Y%m%d') + '.txt'
      Noir::Command::New.createFile note_name
      puts note_name
    end

  end
end
