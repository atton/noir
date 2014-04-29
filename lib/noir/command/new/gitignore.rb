class Noir::Command::New::GitIgnore < Noir::Base::Command
  @description = 'Create new .gitignore'

  GitIgnoreName = '.gitignore'

  def self.createGitIgnore text
    File.open(GitIgnoreName, 'w') do |file|
      file.write(text)
    end
  end

end

require 'noir/command/new/gitignore/vim'
