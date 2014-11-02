class Noir::Command::New::HgIgnore::Tex < Noir::Base::TerminalCommand
  @description = 'Create new .hgignore for TeX'

  HgIgnoreText = %q(
syntax: glob

*.swp

*.log
*.aux
*.dvi
*.pdf
*.toc
*.cpt
)

  def self.execute *args
    Noir::Command::New::HgIgnore.createHgIgnore HgIgnoreText
  end

end

