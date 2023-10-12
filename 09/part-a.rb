#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative "./shared"

class PartA
  extend Shared::InputParser

  def self.run
    input = self.parse_input Common::InputReader.real
    rope = Shared::Rope.new 2
    input.each do |movement|
      movement[:amount].times do
        rope.move movement[:direction]
      end
    end
    puts rope.tail.unique_visited_coordinates
  end
end

if __FILE__ == $0
  PartA.run
end
