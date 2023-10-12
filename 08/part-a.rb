require_relative './shared'

class PartA
  extend Shared::TreeGridInspector
  
  def self.run
    input = Common::InputReader.real
    @grid = Shared::TreeGrid.new(input)
    self.find_visible_trees
    puts @grid.count_visible_trees
  end

  private

  def self.find_visible_trees
    [:above, :below, :left, :right].each do |side|
      self.look_from side
    end
  end
end

PartA.run
