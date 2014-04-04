class Noir::Command < Noir::Base::Command
  class << self
    def execute *args
      # if arguments missing. call help.
      Noir::Command::Help.execute if args.size.zero?
      super *args
    end
  end
end

require 'noir/command/init'
require 'noir/command/completion'
require 'noir/command/help'
