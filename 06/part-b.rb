require_relative './shared'
require "pry-rescue"

class PartB
  extend Shared::MarkerFinder

  def self.run
    self.find_marker 14
  end
end

PartB.run
