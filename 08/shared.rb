require "../common"
require "pry-rescue"

module Shared
  module TreeGridInspector
    private
    
    def look_from(side)
      direction = xy_to_dw_mapping side
      
      width_enumerator(side, direction[:w]) do |w|
        biggest_height_so_far = -1
        
        depth_enumerator(side, direction[:d]) do |d|
          tree_currently_observing = @grid.at(map_dw_to_xy(side: side, d: d, w: w))
          
          next if tree_currently_observing.height <= biggest_height_so_far
  
          tree_currently_observing.is_visible
          biggest_height_so_far = tree_currently_observing.height
        end
      end
    end

    def map_dw_to_xy(side:, d:, w:)
      case side
      when :above, :below
        { x: w, y: d }
      when :left, :right
        { x: d, y: w }
      end
    end
  
    def xy_to_dw_mapping(side)
      case side
      when :above, :below
        { w: :x, d: :y }
      when :left, :right
        { w: :y, d: :x }
      end
    end
  
    def width_enumerator(side, direction, &block)
      @grid.size[direction].times &block
    end
  
    def depth_enumerator(side, direction, &block)
      enumerator = @grid.size[direction].times
      case side
      when :above, :left
        enumerator.each &block
      when :below, :right
        enumerator.reverse_each &block
      end
    end
  end

  class Tree
    attr_reader :height

    def initialize(height)
      @height = height
      @visible = false
    end

    def is_visible?
      @visible
    end

    def is_visible
      @visible = true
    end
  end

  class TreeGrid
    attr_reader :size

    def initialize(map)
      fill_grid(map)
    end

    def at(x:, y:)
      @grid[y][x]
    end

    def count_visible_trees
      @grid.flatten.filter_map { |tree| tree.is_visible? }.size
    end

    private

    def fill_grid(data)
      @size = { x: data.first.length, y: data.length }
      @grid = data.map do |row|
        convert_grid_row row
      end
    end

    def convert_grid_row(row)
      row
        .split("")
        .map do |tree_height|
        Shared::Tree.new tree_height.to_i
      end
    end
  end
end
