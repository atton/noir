module Noir
  class Executer

    def self.command_from_argv
      args          = ARGV.clone
      noir_commands = Noir::Command.constants(true).map(&:to_s)
      command_arr   = ['Noir', 'Command']   # command prefix
      command       = Noir::Command::Help   # default command


      while !args.empty?
        arg = args.shift

        if matched_command = noir_commands.select{|c| c.downcase == arg.downcase}.first

          command_arr << matched_command
          command = eval(command_arr.join('::'))
          if command.superclass == Noir::Base::Command
            noir_commands = command.constants(true).map(&:to_s) # search next command in sub class
          elsif command.superclass ==  Noir::Base::TerminalCommand
            break                                               # search finished by terminal command
          else
            command_arr.pop
            # delete last matched_command, because this class is not inherited Noir::Base::Command
            command = eval(command_arr.join('::'))
            break
          end
        end
      end

      return command
    end

    def self.args_from_argv
      argv         = ARGV.clone
      command_str  = self.command_from_argv.to_s.sub(/^Noir::Command::/, '')
      command_size = command_str.split('::').size
      return argv.drop(command_size)
    end

  end
end
