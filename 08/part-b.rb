require './shared'

class PartB
  def self.run
    input = Common::InputReader.real
    @grid = Shared::TreeGrid.new(input)
    puts self.find_best_scenic_score
  end
  
  def self.find_best_scenic_score
    @grid.size[:x].times do |x|
      @grid.size[:y].times do |y|
        view_point = {x: x, y: y}
        @grid.at(view_point).scenic_score = 
          self.look_right_from(view_point) *
          self.look_left_from(view_point) *
          self.look_down_from(view_point) *
          self.look_up_from(view_point)
      end
    end
    @grid.best_scenic_score
  end

  def self.look_up_from(view_point)
    neighbour = view_point.dup
    while neighbour[:y] > 0
      neighbour[:y] -= 1
      break if self.check_if_neighbour_is_smaller(view_point, neighbour)
    end
    view_point[:y] - neighbour[:y]
  end

  def self.look_left_from(view_point)
    neighbour = view_point.dup
    while neighbour[:x] > 0
      neighbour[:x] -= 1
      break if self.check_if_neighbour_is_smaller(view_point, neighbour)
    end
    view_point[:x] - neighbour[:x]
  end

  def self.look_right_from(view_point)
    neighbour = view_point.dup
    while neighbour[:x] < @grid.size[:x]-1
      neighbour[:x] += 1
      break if self.check_if_neighbour_is_smaller(view_point, neighbour)
    end
    neighbour[:x] - view_point[:x]
  end

  def self.look_down_from(view_point)
    neighbour = view_point.dup
    while neighbour[:y] < @grid.size[:y]-1
      neighbour[:y] += 1
      break if self.check_if_neighbour_is_smaller(view_point, neighbour)
    end
    neighbour[:y] - view_point[:y]
  end

  def self.check_if_neighbour_is_smaller(we, neighbour)
    @grid.at(we).height <= @grid.at(neighbour).height
  end
end

PartB.run