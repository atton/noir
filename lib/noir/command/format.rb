class Noir::Command::Format < Noir::Base::Command
  @description = 'format string utils'
end

require 'noir/command/format/lgtm'
require 'noir/command/format/pdf_url'
