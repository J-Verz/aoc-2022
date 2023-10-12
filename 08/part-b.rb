require_relative './shared'

class PartB
  extend Shared::ScenicScoreCalculator

  def self.run
    input = Common::InputReader.real
    @grid = Shared::TreeGrid.new(input)
    puts self.find_best_scenic_score
  end

  private
  
  def self.find_best_scenic_score
    self.calculate_scenic_scores
    @grid.find_best_scenic_score
  end
end

PartB.run