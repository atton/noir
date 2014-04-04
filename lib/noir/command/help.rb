module Noir::Command
  class Help < Noir::Base::TerminalCommand

    @description = "show help"

    class << self
      def execute *args
        puts 'noir : utilities'
        puts '-----'

        Noir::Command.constants(true).
          map{|c| eval('Noir::Command::'+c.to_s)}.
          select{|c| c.ancestors.include? Noir::Base::Command}.
          each(&:description)
      end
    end

  end
end
