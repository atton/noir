require 'optparse'

module Noir

  class Options

    Help = :help

    @@options = {}

    def self.parse_options_from_argv!
      parser = OptionParser.new

      parser.program_name = 'noir'
      parser.version      = Noir::VERSION
      parser.on('-h', '--help'){|v| @@options[Noir::Options::Help] = v}

      parser.parse!(ARGV)

      @@options
    end

    def self.exist? const_symbol = nil
      @@options.has_key?(const_symbol)
    end
  end

end

