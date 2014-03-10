module Noir::Base

  class Command

    class << self   # class methods
      attr_accessor :description

      def description
        if @description.nil?
          raise "Undefined description : " + self.to_s
        else
          puts @description
        end
      end
    end

    def self.execute
      if self == Noir::Base::Command
        raise 'called raw Noir::Base::Command.execute. please call it in extended class.'
      end

      # default execute is show description with sub commands.
      self.description
      self.sub_commands.each{|c| c.description}
    end

    def self.sub_commands
      consts = self.constants - self.superclass.constants
      consts.select{|c| self.const_get(c).ancestors.include?(Noir::Base::Command)}
    end

  end
end
