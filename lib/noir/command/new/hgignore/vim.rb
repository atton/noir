class Noir::Command::New::HgIgnore::Vim < Noir::Base::TerminalCommand
  @description = 'Create new .hgignore for vim'

  HgIgnoreText = %q(
syntax: glob

*.swp
)

  def self.execute *args
    Noir::Command::New::HgIgnore.createHgIgnore HgIgnoreText
  end

end

