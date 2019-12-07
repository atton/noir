class Noir::Command::New::Note < Noir::Base::TerminalCommand
  @description = 'Create empty txt. filename format is <serial-no>_<date>.txt'

  TimeFormat   = '%Y%m%d'
  FileNameGlob = '[0-9]*_????????.txt'
  SerialDigitRange = 1..3

  class << self

    def serial_format number
      digit_from_env = ENV['NOIR_NOTE_SERIAL_DIGIT']

      # default digit is 2
      digit = digit_from_env.nil? ? 2 : digit_from_env.to_i
      if SerialDigitRange.cover?(digit)
        return format("%0#{digit}d", number)
      else
        raise ["Invalid ENV['NOIR_NOTE_SERIAL_DIGIT'](#{digit_from_env}).",
               "support digit is [#{SerialDigitRange.to_a.join(', ')}]."].join("\n")
      end
    end

    def create_new_note
      note_num  = Dir.glob(FileNameGlob).size + 1
      note_name = serial_format(note_num) + '_' + Time.now.strftime(TimeFormat) + '.txt'
      Noir::Command::New.createFile note_name
      return note_name
    end

    def execute *args
      puts create_new_note
    end

  end
end
