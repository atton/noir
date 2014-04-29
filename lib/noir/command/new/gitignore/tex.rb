class Noir::Command::New::GitIgnore::Tex < Noir::Base::TerminalCommand
  @description = 'Create new .gitignore for TeX'

  GitIgnoreText = %q(
*.swp

*.log
*.aux
*.dvi
*.pdf
*.toc
)

  def self.execute *args
    Noir::Command::New::GitIgnore.createGitIgnore GitIgnoreText
  end

end

