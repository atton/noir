require 'time'

class Noir::Command::Calculate::Time < Noir::Base::TerminalCommand
  @description = 'calculate formatted time in .txt file. time format : (%Y/%m/%d %H:%M:%S)'

  TimeFormat  = "%Y/%m/%d %H:%M:%S"
  TimeRegexp  = Regexp.new('^\s*\d{4}/\d{2}/\d{2} \d{2}:\d{2}:\d{2}$')

  class << self
    def execute *args
      raise 'Please input target on commant arguments. (directory or .txt file)' if args.size.zero?

      files = args.map{|f| extract_path(f)}.flatten
    end

    def extract_path path
      raise "File not found. #{path}" unless File.exists?(path)
      return path if File.file?(path)

      if File.directory?(path)
        return Dir.entries(path).reject{|filename| filename.start_with?('.')}
      end

      raise "Invalid path. please input file or directory #{path}"
    end

    def pick_up_times path
      text  = File.read(path)
      times = text.split("\n").select{|t| t =~ TimeRegexp}.map{|t| t.match(TimeRegexp).to_s.gsub(/^\s*/, '')}

      raise "Count of formatted time is not even. : #{path}" unless times.size.even?

      times = times.map{|t| Time.strptime(t, TimeFormat)}

      raise "Formatted time was not sorted in #{path}" unless times.sort == times

      diffs = times.map.each_slice(2).to_a
    end
  end
end
