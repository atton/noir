class Noir::Command::Completion < Noir::Base::TerminalCommand

  @description = 'it is completion for shell. return command suggestion'

  class << self

    def execute *args
      if Noir::Options.exist? Noir::Options::Help
        description
        exit
      end
      puts suggestions(args)
    end

    def suggestions list
      if list.size.zero?
        return suggestions_from_command Noir::Command, nil
      end

      commands  = [:Noir, :Command] + list

      matched_commands = [commands.first]
      commands = commands.drop(1)

      while true
        consts = eval(matched_commands.map(&:to_s).join('::')).constants(true)

        break if commands.size.zero?
        matched_command = consts.find{|c| c.to_s.downcase == commands.first.to_s.downcase}
        break if matched_command.nil?

        matched_commands << matched_command
        commands = commands.drop(1)
      end

      command_class = eval(matched_commands.map(&:to_s).join('::'))
      suggestions_from_command(command_class, commands.first)
    end

    def suggestions_from_command klass, pattern = nil
      suggests = klass.constants(true).map(&:to_s).map(&:downcase)

      unless pattern.nil?
        suggests = suggests.select{|c| c.start_with? pattern.downcase}
      end

      return suggests
    end
  end

end
