module Noir::Base

  class Command

    class << self   # class methods
      def description
        if @description.nil?
          raise "Undefined description : " + self.to_s
        else
          puts self.to_s.sub(/^Noir::Command::/, '').downcase + "\t: " + @description
        end
      end

      def execute
        if self == Noir::Base::Command
          raise 'called raw Noir::Base::Command.execute. please call it in extended class.'
        end

        # default execute is show description with sub commands.
        description
        sub_commands.each{|c| c.description}
      end

      def sub_commands
        consts = constants - superclass.constants
        consts.select{|c| const_get(c).ancestors.include?(Noir::Base::Command)}
      end
    end

  end
end
