class Noir::Command::Edit < Noir::Base::Command
  @description = 'edit files'

  def self.editor
     ENV['EDITOR'] || 'vim'
  end

end

require 'noir/command/edit/note'
