require 'uri'

class Noir::Command::Format::LGTM < Noir::Base::TerminalCommand
  @description = 'puts LGTM Markdown string from image URL'

  def self.execute *args
    raise 'URL Missing. Please input a link in argument.'if args.empty?
    url = args.first

    if URI.regexp.match(url)
      puts "[![LGTM](#{url})](#{url})"
    else
      puts "Argument '#{url}' is not URL."
    end

  end
end

