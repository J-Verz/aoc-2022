require_relative './shared'

class PartB
  def self.run
    input = Common::InputReader.real
    @root = Shared::DirectoryTreeParser.parse input
    puts self.find_smallest_folder_thats_big_enough
  end

  def self.find_smallest_folder_thats_big_enough
    @threshold = @root.size - 40_000_000
    @folders_over_threshold = Shared::ConditionChecker.check(@root) {|element| element.size_over @threshold}
    @folders_over_threshold.sort.first
  end

end

PartB.run
