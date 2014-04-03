module Noir::Command
  class Completion < Noir::Base::TerminalCommand

    @description = 'it is completion for shell. return command suggestion'

    class << self

      def execute lists
        return ['hoge', 'fuga']
      end

    end

  end
end
