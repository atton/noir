module Noir::Command
  class Completion < Noir::Base::TerminalCommand

    @description = 'it is completion for shell. return command suggestion'

    class << self

      def suggestions list
        if list.size.zero?
          return Noir::Command.constants(true).map(&:to_s).map(&:downcase)
        end

        command  = ['Noir', 'Command']

        # exist check. delete last elem, check remain elements
        commands_from_list = list[0..-2].map(&:capitalize)
        command = ((command + commands_from_list).join('::'))
        command = eval(command)

        command.constants(true).map(&:to_s).select{|c| c.downcase.start_with? list.last}
      end

    end

  end
end
