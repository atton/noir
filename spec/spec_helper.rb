require 'noir'

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

# utils

def stub_commands
  stub_const('Noir::Command::Hoge'                               , Class.new(Noir::Base::Command))
  stub_const('Noir::Command::Hoge::SubCommand'                   , Class.new(Noir::Base::Command))
  stub_const('Noir::Command::Hoge::SubCommand::SubSubCommand'    , Class.new(Noir::Base::Command))
  stub_const('Noir::Command::Hoge::SubCommand::SubSubNonCommand' , Class.new)
  stub_const('Noir::Command::Hoge::SubCommandTwo'                , Class.new(Noir::Base::Command))
  stub_const('Noir::Command::Hoge::SubNonCommand'                , Class.new)
  stub_const('Noir::Command::Fuga'                               , Class.new(Noir::Base::TerminalCommand))

=begin
        # stub_const is this structure
        module Noir::Command
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
          end
          class Fuga < Noir::Base::TerminalCommand
          end
        end
=end

end
