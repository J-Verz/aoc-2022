# frozen_string_literal: true
require '../common'
require 'pry-rescue'

module Shared
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
  
  class RopeEnd
    attr_reader :position
  
    def initialize
      @position = Coords.new
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
  end
  
  class RopeHead < RopeEnd; end
  
  class RopeTail < RopeEnd
    attr_reader :visited_coordinates
  
    def initialize
      super
      @visited_coordinates = Hash.new do |hash, key|
        hash[key] = Hash.new do |hash, key|
          hash[key] = true
        end
      end
      @visited_coordinates[0][0]
      # binding.pry
    end
  
    def follow(head)
      distance_to_head = (self.position - head.position).to_h
      case distance_to_head
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
      end
      @visited_coordinates[self.position.x][self.position.y]
    end
  
    def unique_visited_coordinates
      @visited_coordinates.map { |key, value| value.size }.sum
    end
  end
end
