module Noir
  class Executer

    def self.command_from_argv
      args          = ARGV.clone
      noir_commands = Noir::Command.constants(true).map(&:to_s)
      command_arr   = ['Noir', 'Command']   # command prefix


      while !args.empty?
        arg = args.shift

        if matched_command = noir_commands.find{|c| c.downcase == arg.downcase}

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

      return command || Noir::Command  # default command
    end

    def self.args_from_argv
      argv         = ARGV.clone
      command_str  = self.command_from_argv.to_s.sub(/^Noir::Command/, '')
      command_str  = command_str.sub(/^::/, '')
      command_size = command_str.split('::').size
      return argv.drop(command_size)
    end

    def self.execute
      command_from_argv.execute *args_from_argv
    end

  end
end
