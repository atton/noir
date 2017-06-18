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

        # check invalid command
        check_command_not_found(*args)

        # default execute is show description with sub commands.
        description
        puts '-- sub commands --'
        sub_commands.map{|c|eval(self.to_s + '::' + c.to_s)}.each{|c| c.description}
      end

      def sub_commands
        consts = constants - superclass.constants
        consts = consts.select do |const|
          const_get(const).class == Class &&
          const_get(const).ancestors.include?(Noir::Base::Command)
        end
      end

      def check_command_not_found command=nil, *args
        return if command.nil?

        raise 'command not found : ' + command
      end
    end

  end
end
