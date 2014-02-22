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

  end
end
