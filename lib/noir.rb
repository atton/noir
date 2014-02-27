require 'noir/version'
require 'noir/options'
require 'noir/base'
require 'noir/base/terminal_command'

module Noir
  # Your code goes here...
  def self.main
    Noir::Options.parse_options_from_argv!
    puts ARGV
  end
end
