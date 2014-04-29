class Noir::Command::New::GitIgnore::Vim < Noir::Base::TerminalCommand
  @description = 'Create new .gitignore for vim'

  GitIgnoreText = %q(
*.swp
)

  def self.execute *args
    Noir::Command::New::GitIgnore.createGitIgnore GitIgnoreText
  end

end

