module Noir
  class Executer

    # utils

    def self.find_command command_arr, search_str
      command = eval(command_arr.join('::'))

      commands    = command.sub_commands.map(&:to_s)
      matched_str = commands.find{|c| c.downcase == search_str.downcase}
      matched_str = find_abbr_command(commands, search_str) if matched_str.nil?

      return nil if matched_str.nil?
      matched_arr = command_arr + [matched_str]

      return matched_str
    end

    def self.find_abbr_command commands, search_str
      # abbrev match
      matched_commands = commands.select{|c| c.downcase.start_with? search_str}

      return nil if matched_commands.empty?
      unless matched_commands.size == 1
        raise "#{search_str} is ambiguous. matched #{matched_commands}"
      end

      matched_commands.first
    end

    def self.command_from_argv
      args          = ARGV.clone
      command_arr   = ['Noir', 'Command']   # command prefix and default command

      while true
        break unless search_str      = args.shift
        break unless matched_command = find_command(command_arr, search_str)

        command_arr << matched_command
      end

      return eval(command_arr.join('::'))
    end

    def self.args_from_argv
      argv         = ARGV.clone
      command_str  = self.command_from_argv.to_s.sub(/^Noir::Command/, '')
      command_str  = command_str.sub(/^::/, '')
      command_size = command_str.split('::').size
      return argv.drop(command_size)
    end

    # inherited methods

    def self.execute
      Noir::Options.parse_options_from_argv!

      if Noir::Options.exist? Noir::Options::Help
        return command_from_argv.description
      end

      command_from_argv.execute *args_from_argv
    end

  end
end
