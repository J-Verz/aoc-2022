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
          tree_currently_observing = @grid[map_dw_to_xy(side: side, d: d, w: w)]

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

  module ScenicScoreCalculator
    def calculate_scenic_scores
      @grid.size[:x].times do |x|
        @grid.size[:y].times do |y|
          self.calculate_scenic_score_for x: x, y: y
        end
      end
    end

    def calculate_scenic_score_for(point)
      @grid[point].scenic_score =
        self.look_right_from(point) *
        self.look_left_from(point) *
        self.look_down_from(point) *
        self.look_up_from(point)
    end

    def look_up_from(view_point)
      neighbour = view_point.dup
      while neighbour[:y] > 0
        neighbour[:y] -= 1
        break if self.check_if_neighbour_is_smaller(view_point, neighbour)
      end
      view_point[:y] - neighbour[:y]
    end

    def look_left_from(view_point)
      neighbour = view_point.dup
      while neighbour[:x] > 0
        neighbour[:x] -= 1
        break if self.check_if_neighbour_is_smaller(view_point, neighbour)
      end
      view_point[:x] - neighbour[:x]
    end

    def look_right_from(view_point)
      neighbour = view_point.dup
      while neighbour[:x] < @grid.size[:x] - 1
        neighbour[:x] += 1
        break if self.check_if_neighbour_is_smaller(view_point, neighbour)
      end
      neighbour[:x] - view_point[:x]
    end

    def look_down_from(view_point)
      neighbour = view_point.dup
      while neighbour[:y] < @grid.size[:y] - 1
        neighbour[:y] += 1
        break if self.check_if_neighbour_is_smaller(view_point, neighbour)
      end
      neighbour[:y] - view_point[:y]
    end

    def check_if_neighbour_is_smaller(we, neighbour)
      @grid[we].height <= @grid[neighbour].height
    end
  end

  class Tree
    attr_reader :height
    attr_accessor :scenic_score

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

    def [](coords)
      @grid[coords[:y]][coords[:x]]
    end

    def count_visible_trees
      @grid.flatten.filter_map { |tree| tree.is_visible? }.size
    end

    def find_best_scenic_score
      @grid.flatten.map(&:scenic_score).max
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
