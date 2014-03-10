module Noir::Base
  class TerminalCommand < Noir::Base::Command

    class << self

      def execute *args
        if self == Noir::Base::TerminalCommand
          raise 'called raw Noir::Base::TerminalCommand.execute. please call it in extended class.'
        end
      end

    end

  end
end
