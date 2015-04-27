class Noir::Command::New::HgIgnore < Noir::Base::TerminalCommand
  @description = "Create new .hgignore. supported #{Noir::Command::New::GitIgnore::SupportedKinds}"

  HgIgnoreName   = '.hgignore'
  HgIgnoreHeader = "syntax: glob\n\n"

  def self.execute *args
    text = Noir::Command::New::GitIgnore.ignore_texts_from_kinds(args)
    Noir::Command::New.createFile(HgIgnoreName, HgIgnoreHeader + text)
  end
end
