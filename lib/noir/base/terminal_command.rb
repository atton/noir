module Noir::Base
  class TerminalCommand < Noir::Base::Command

    class << self

      def execute *args
        if self == Noir::Base::TerminalCommand
          raise 'called raw Noir::Base::TerminalCommand.execute. please call it in extended class.'
        end

        raise 'please override in extended class'
      end

      def sub_commands
        return []
      end

    end

  end
end
