class Noir::Command::Init < Noir::Base::Command
  @description = "init script for shell"

  class << self
    def execute *args
      check_command_not_found args.first
      super *args
    end
  end

end

require 'noir/command/init/zsh'
