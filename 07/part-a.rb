require "./shared"

class PartA
  def self.run
    input = Common::InputReader.real
    @root = Shared::DirectoryTreeParser.parse input
    puts self.sum_of_sizes_under_100_001
  end

  def self.sum_of_sizes_under_100_001
    @sizes_under_100_001 = []
    self.find_if_size_is_under_100_001 @root
    @sizes_under_100_001.push @root.size if @root.size_under_100_001?
    @sizes_under_100_001.sum
  end

  def self.find_if_size_is_under_100_001(element)
    element.children.each do |child|
      next unless child.is_a? Shared::Folder
      self.find_if_size_is_under_100_001 child
      @sizes_under_100_001.push child.size if child.size_under_100_001?
    end
  end
end

PartA.run
