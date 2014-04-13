module Noir
  class Executer

    # utils

    def self.find_command command_arr, search_str
      command = eval(command_arr.join('::'))

      # finish find by terminal command
      return nil if command.superclass == Noir::Base::TerminalCommand

      commands = command.constants(true).map(&:to_s)

      commands.find{|c| c.downcase == search_str.downcase}
    end

    def self.command_from_argv
      args          = ARGV.clone
      command_arr   = ['Noir', 'Command']   # command prefix

      while true
        break unless search_str      = args.shift
        break unless matched_command = find_command(command_arr, search_str)

        command_arr << matched_command

        unless eval(command_arr.join('::')).ancestors.include?(Noir::Base::Command)
          # delete last matched_command.
          # because this matched class is not inherited Noir::Base::Command
          command_arr.pop
          break
        end
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
      command_from_argv.execute *args_from_argv
    end

  end
end
