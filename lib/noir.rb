require 'noir/version'
require 'noir/options'
require 'noir/executer'
require 'noir/base'
require 'noir/base/terminal_command'
require 'noir/command'

module Noir
  def self.main
    Noir::Executer.execute
  end
end
