require 'noir'

module Noir::Base
  class TerminalCommand < Noir::Base::Command

    def self.execute *args
      if self == Noir::Base::TerminalCommand
        raise 'called raw Noir::Base::TerminalCommand.execute. please call it in extended class.'
      end

    end

  end
end
