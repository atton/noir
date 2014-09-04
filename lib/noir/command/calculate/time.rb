require 'time'

class Noir::Command::Calculate::Time < Noir::Base::TerminalCommand
  @description = 'calculate formatted time in .txt file. time format : (%Y/%m/%d %H:%M:%S)'

  TimeFormat  = "%Y/%m/%d %H:%M:%S"
  TimeRegexp  = Regexp.new('^\s*\d{4}/\d{2}/\d{2} \d{2}:\d{2}:\d{2}$')

  class << self
    def execute *args
      raise 'Please input target on commant arguments. (directory or .txt file)' if args.size.zero?

      files = args.map{|f| extract_path(f)}.flatten

      time_pairs = files.map{|f| pick_up_times(f)}

      total_time = 0
      files.zip(time_pairs) do |file, pairs|
        print_file_total file, pairs
        total_time += calc_total(pairs)
        puts '-----'
      end

      puts "all total time : #{seconds_to_string(total_time)}"
    end

    def extract_path path
      raise "File not found. #{path}" unless File.exists?(path)
      return path if File.file?(path)

      if File.directory?(path)
        return Dir.entries(path).reject{|filename| filename.start_with?('.') || File.directory?(filename)}
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

    def calc_total time_pairs
      time_pairs.map{|start, finish| finish - start}.inject(:+) || 0
    end

    def print_file_total file, time_pairs
      if time_pairs.empty?
        puts("Formatted time not found in : #{file}")
        return
      end

      puts file

      time_pairs.each do |start, finish|
        diff = finish - start
        puts "#{start.strftime(TimeFormat)} => #{finish.strftime(TimeFormat)} : #{seconds_to_string(diff)}"
      end

      puts "file total : #{seconds_to_string(calc_total(time_pairs))}"
    end

    def seconds_to_string time_sec
      hours    = time_sec.to_i / 3600
      mins     = (time_sec - (3600 * hours)) / 60
      seconds  = (time_sec - (3600 * hours)) % 60

      format("%d:%02d:%02d", hours, mins, seconds)
    end
  end
end
