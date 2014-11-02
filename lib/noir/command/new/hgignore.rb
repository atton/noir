class Noir::Command::New::HgIgnore < Noir::Base::Command
  @description = 'Create new .hgignore'

  HgIgnoreName = '.hgignore'

  def self.createHgIgnore text
    Noir::Command::New.createFile(HgIgnoreName, text)
  end

end

require 'noir/command/new/hgignore/agda'
require 'noir/command/new/hgignore/tex'
require 'noir/command/new/hgignore/vim'
