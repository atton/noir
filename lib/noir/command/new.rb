class Noir::Command::New < Noir::Base::Command
  @description = 'Create new files'

  def self.createFile filename, text=''
    File.open(filename, 'w') do |file|
      file.write(text.sub(/^\n/, ''))
    end
  end

end

require 'noir/command/new/note'
require 'noir/command/new/gitignore'
require 'noir/command/new/makefile'
