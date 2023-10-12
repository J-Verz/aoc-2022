#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative './shared'

class PartB
  extend Shared::InputParser

  def self.run
    input = self.parse_input Common::InputReader.real
    rope = Shared::Rope.new 10
    input.each do |movement|
      movement[:amount].times do
        rope.move movement[:direction]
        binding.pry
      end
    end
    puts rope.tail.unique_visited_coordinates
  end
end

if __FILE__ == $0
  PartB.run
end
