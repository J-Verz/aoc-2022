#!/usr/bin/env ruby
# frozen_string_literal: true
require "./shared"

def debug(*values)
  puts values if ARGV[0] == "--debug"
end

class PartA
  attr_reader :head, :tail
  DIRECTION_TO_METHOD = {
    "U" => :up,
    "D" => :down,
    "R" => :right,
    "L" => :left,
  }

  def self.run
    input = self.parse_input Common::InputReader.real
    head = Shared::RopeHead.new
    tail = Shared::RopeTail.new
    input.each do |movement|
      movement[:amount].times do
        head.send movement[:direction]
        tail.follow head
        debug "HEAD #{head.position}", "TAIL #{tail.position}"
      end
    end
    puts tail.unique_visited_coordinates
  end

  private

  def self.parse_input(input)
    input.map do |line|
      movement = line.split ' '
      {
        :direction => DIRECTION_TO_METHOD.dig(movement[0]),
        :amount => movement[1].to_i
      }
    end
  end
end

if __FILE__ == $0
  PartA.run
end
