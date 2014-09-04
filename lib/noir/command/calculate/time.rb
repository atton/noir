class Noir::Command::Calculate::Time < Noir::Base::TerminalCommand
  @description = 'calculate formatted time in .txt file. time format : (%Y/%m/%d %H:%M:%S")'

  class << self
    def execute *args
      raise 'Please input target on commant arguments. (directory or .txt file)' if args.size.zero?

      files = args.map{|f| extract_path(f)}.flatten

      calc_time files
    end

    def extract_path path
      raise "File not found. #{path}" unless File.exists?(path)
      return path if File.file?(path)

      if File.directory?(path)
        return Dir.entries(path).reject{|filename| filename.start_with?('.')}
      end

      raise "Invalid path. please input file or directory #{path}"
    end

  end
end
