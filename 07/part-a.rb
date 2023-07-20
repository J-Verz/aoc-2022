require "./shared"

class PartA
  def self.run
    input = Common::InputReader.real
    @root = Shared::DirectoryTreeParser.parse input
    puts self.sum_of_sizes_under_100_001
  end

  def self.sum_of_sizes_under_100_001
    @sizes_under_100_001 = Shared::ConditionChecker.check(@root) {|element| element.size_under_100_001? }
    @sizes_under_100_001.sum
  end

end

PartA.run
