require_relative './shared'
require 'pry-rescue'

class PartA
    extend Shared::MarkerFinder
    
    def self.run
        self.find_marker 4
    end
end

PartA.run