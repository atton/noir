class Noir::Command::New::GitIgnore < Noir::Base::Command
  @description = 'Create new .gitignore'

  GitIgnoreName = '.gitignore'

  def self.createGitIgnore text
    Noir::Command::New.createFile(GitIgnoreName, text)
  end

end

require 'noir/command/new/gitignore/vim'
require 'noir/command/new/gitignore/tex'
