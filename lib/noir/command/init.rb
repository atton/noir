module Noir::Command

  class Init < Noir::Base::Command
    @description = "init script for shell"
  end

end

require 'noir/command/init/zsh'
