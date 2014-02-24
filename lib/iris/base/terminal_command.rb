require 'iris'

module Iris::Base
  class TerminalCommand < Iris::Base::Command

    def self.execute *args
      if self == Iris::Base::TerminalCommand
        raise 'called raw Iris::Base::TerminalCommand.execute. please call it in extended class.'
      end

    end

  end
end
