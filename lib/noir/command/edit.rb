class Noir::Command::Edit < Noir::Base::Command
  @description = 'edit files'
end

require 'noir/command/edit/weekly_report'
require 'noir/command/edit/note'
