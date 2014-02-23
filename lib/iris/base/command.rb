require 'iris'

module Iris::Base

  class Command

    @@description = nil

    def self.description
      if @@description.nil?
        raise "Undefined description :" + self.class.to_s
      else
        puts @@description
      end
    end

    def self.execute
      if self == Iris::Base::Command
        raise 'called raw Iris::Base::Command.execute. please call it in extended class.'
      end

      # default execute is show description with sub commands.
      self.description
      self.sub_commands.each{|c| c.description}
    end

    def self.sub_commands
      consts = self.constants - self.superclass.constants
      consts.select{|c| self.const_get(c).ancestors.include?(Iris::Base::Command)}
    end

  end
end
