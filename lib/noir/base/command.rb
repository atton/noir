module Noir::Base

  class Command

    class << self   # class methods
      def description
        if @description.nil?
          raise "Undefined description : " + self.to_s
        else
          puts self.to_s.split(':').last.downcase.ljust(15) + " : " + @description
        end
      end

      def execute *args
        if self == Noir::Base::Command
          raise 'called raw Noir::Base::Command.execute. please call it in extended class.'
        end

        # default execute is show description with sub commands.
        description
        puts '-- sub commands --'
        sub_commands.map{|c|eval(self.to_s + '::' + c.to_s)}.each{|c| c.description}
      end

      def sub_commands
        consts = constants - superclass.constants
        consts = consts.select{|c| const_get(c).ancestors.include?(Noir::Base::Command)}
      end

      def check_command_not_found command_arr
        return if command_arr.nil?
        return if command_arr.empty?

        raise 'command not found : ' + command_arr.first.to_s
      end
    end

  end
end
