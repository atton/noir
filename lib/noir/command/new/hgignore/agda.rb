class Noir::Command::New::HgIgnore::Agda < Noir::Base::TerminalCommand
  @description = 'Create new .hgignore for Agda'

  HgIgnoreText = %q(
syntax: glob

*.swp

*.agdai
*.*~
)

  def self.execute *args
    Noir::Command::New::HgIgnore.createHgIgnore HgIgnoreText
  end

end
