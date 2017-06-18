class Noir::Command < Noir::Base::Command
  class << self
    def execute *args
      # if arguments missing. call help.
      Noir::Command::Help.execute if args.size.zero?
      check_command_not_found(*args)
    end
  end
end

require 'noir/command/init'
require 'noir/command/completion'

require 'noir/command/calculate'
require 'noir/command/edit'
require 'noir/command/format'
require 'noir/command/help'
require 'noir/command/new'
require 'noir/command/summarize'
