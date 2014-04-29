class Noir::Command::New < Noir::Base::Command
  @description = 'Create new files'
end

require 'noir/command/new/note'
require 'noir/command/new/gitignore'
require 'noir/command/new/makefile'
