module Noir::Command
  class Completion < Noir::Base::TerminalCommand

    @description = 'it is completion for shell. return command suggestion'

    class << self

      def suggestions list
        if list.size.zero?
          return Noir::Command.constants(true).map(&:to_s).map(&:downcase)
        end

        command  = ['Noir', 'Command']

        begin
          # all list elements matched in noir commands.
          # return sub commands from matched command
           command = eval((command + list.map(&:capitalize)).join('::'))
           return suggestions_from_command(command, nil)
        rescue NameError
          # not matched all elements
        end

        begin
          # list (exclude last element) matched in noir commands.
          # return sub commands from matched command with match by last element
          commands_from_list = list[0..-2].map(&:capitalize)
          command = eval((command + commands_from_list).join('::'))
          return suggestions_from_command(command, list.last)
        end

      end

      def suggestions_from_command klass, pattern = nil
        suggests = klass.constants(true).map(&:to_s).map(&:downcase)

        unless pattern.nil?
          suggests = suggests.select{|c| c.start_with? pattern.downcase}
        end

        return suggests
      end
    end

  end
end
