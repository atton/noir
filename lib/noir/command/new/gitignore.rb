class Noir::Command::New::GitIgnore < Noir::Base::TerminalCommand
  @description = 'Create new .gitignore'

  GitIgnoreName = '.gitignore'

  module GitIgnoreTexts
    Vim = %q(
    *.swp
)

    TeX = %q(
*.bbl
*.blg
*.lof
*.lol
*.lot
*.log
*.aux
*.dvi
*.toc
*.cpt
)

  end

  def self.gitignore_texts_from_kinds kinds
    kinds = kinds.map(&:downcase).map(&:to_sym)
    if kinds.empty?
      raise 'Please input some kinds of gitignore'
    end
    unless kinds.all?{|k| GitIgnoreTexts.constants.map(&:downcase).include?(k)}
      raise 'Unsupported kinds'
    end

    kinds.map{|k| GitIgnoreTexts.const_get(GitIgnoreTexts.constants.find{|c| c.downcase == k})}.join("\n\n")
  end

  def self.createGitIgnore text
    Noir::Command::New.createFile(GitIgnoreName, text)
  end

  def self.execute *args
    createGitIgnore gitignore_texts_from_kinds(args)
  end
end
