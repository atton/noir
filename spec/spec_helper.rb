require 'noir'
require 'rspec/temp_dir'

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

# utils

def stub_commands
  stub_const('Noir::Command::Hoge'                               , Class.new(Noir::Base::Command))
  stub_const('Noir::Command::Hoge::SubCommand'                   , Class.new(Noir::Base::Command))
  stub_const('Noir::Command::Hoge::SubCommand::SubSubCommand'    , Class.new(Noir::Base::Command))
  stub_const('Noir::Command::Hoge::SubCommand::SubSubNonCommand' , Class.new)
  stub_const('Noir::Command::Hoge::SubCommandTwo'                , Class.new(Noir::Base::Command))
  stub_const('Noir::Command::Hoge::Piyo'                         , :piyo)
  stub_const('Noir::Command::Hoge::SubNonCommand'                , Class.new)
  stub_const('Noir::Command::Fuga'                               , Class.new(Noir::Base::TerminalCommand))
  stub_const('Noir::Command::FugaFuga'                           , Class.new(Noir::Base::TerminalCommand))

# stub_const is this structure
=begin
    class Noir::Command
      class Hoge < Noir::Base::Command
        class SubCommand < Noir::Base::Command
          class SubSubCommand < Noir::Base::Command
          end
          class SubSubNonCommand
          end
        end

        class SubCommandTwo < Noir::Base::Command
        end

        class SubNonCommand
        end
        Piyo = :piyo
      end
      class Fuga < Noir::Base::TerminalCommand
      end
      class FugaFuga < Noir::Base::TerminalCommand
      end
    end
=end

end

shared_context :dependencie_on_current_directory do
  include_context 'uses temp dir'
  around do |spec|
    Dir.chdir(temp_dir) do
      spec.run
    end
  end
end

# for ruby 1.9.2

unless File.respond_to?(:write)
  class File
    def self.write filename, contents
      open(filename, 'w'){|f| f.write(contents)}
    end
  end
end
