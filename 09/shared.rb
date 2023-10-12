# frozen_string_literal: true
require_relative '../common'
require 'pry-rescue'
require 'pp'

DAY = '09'

def debug(*values)
  puts values if ARGV[0] == "--debug"
end

module Shared
  module InputParser
    DIRECTION_TO_METHOD = {
      "U" => :up,
      "D" => :down,
      "R" => :right,
      "L" => :left,
    }

    def parse_input(input)
      input.map do |line|
        movement = line.split ' '
        {
          :direction => DIRECTION_TO_METHOD.dig(movement[0]),
          :amount => movement[1].to_i
        }
      end
    end
  end
  module VisitedCoordinatesTracker
    attr_reader :visited_coordinates

    def setup_visited_coordinates
      @visited_coordinates = Hash.new do |hash, key|
        hash[key] = Hash.new do |hash, key|
          hash[key] = true
        end
      end
      mark_coordinates_as_visited Coords.new
    end

    def mark_coordinates_as_visited(coords)
      @visited_coordinates[coords.x][coords.y]
    end

    def unique_visited_coordinates
      @visited_coordinates.map { |key, value| value.size }.sum
    end
  end

  class Coords
    attr_accessor :x, :y

    def initialize(x: 0, y: 0)
      @x = x
      @y = y
    end

    def -(other)
      Coords.new x: self.x - other.x, y: self.y - other.y
    end

    def to_h
      { x: @x, y: @y }
    end

    def inspect
      self.to_h.inspect
    end

    def to_s
      inspect
    end
  end

  class Rope
    def initialize(size)
      @sections = Array.new(size) { Shared::RopeSection.new }
    end

    def head
      @sections.first
    end

    def tail
      @sections.last
    end

    def beheaded
      @sections.drop(1)
    end

    def move(direction)
      head.send direction
      beheaded.zip(@sections).each {|sections| sections[0].follow sections[1] }
    end
  end

  class RopeSection
    include Shared::VisitedCoordinatesTracker
    attr_reader :position

    def initialize
      @position = Coords.new
      setup_visited_coordinates
    end

    def name
      self.class.to_s
    end

    def up
      debug "#{self.name} going up"
      @position.y += 1
      self
    end

    def down
      debug "#{self.name} going down"
      @position.y -= 1
      self
    end

    def right
      debug "#{self.name} going right"
      @position.x += 1
      self
    end

    def left
      debug "#{self.name} going left"
      @position.x -= 1
      self
    end

    def follow(predecessor)
      distance_to_predecessor = (self.position - predecessor.position).to_h
      
      case distance_to_predecessor
      when { x: 0, y: -2 }
        self.up
      when { x: 0, y: 2 }
        self.down
      when { x: -2, y: 0 }
        self.right
      when { x: 2, y: 0 }
        self.left
      when { x: -1, y: -2 }
        self.up.right
      when { x: 1, y: -2 }
        self.up.left
      when { x: -1, y: 2 }
        self.down.right
      when { x: 1, y: 2 }
        self.down.left
      when { x: -2, y: -1 }
        self.up.right
      when { x: 2, y: -1 }
        self.up.left
      when { x: -2, y: 1 }
        self.down.right
      when { x: 2, y: 1 }
        self.down.left
      when { x: -1, y: 0 }
      when { x: 1, y: 0 }
      when { x: 0, y: 1 }
      when { x: 0, y: -1 }
      when { x: 0, y: 0 }
      when { x: 1, y: 1 }
      when { x: -1, y: -1 }
      when { x: 1, y: -1 }
      when { x: -1, y: 1 }
      else
        raise 'Difference wrong'
      end
      mark_coordinates_as_visited self.position
    end
  end
end
