class Noir::Command::New::Makefile < Noir::Base::Command
  @description = 'Create new Makefile'

  MakefileName = 'Makefile'

  def self.createMakefile text
    Noir::Command::New.createFile(MakefileName, text)
  end
end
