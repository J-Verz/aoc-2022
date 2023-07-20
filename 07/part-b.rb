require "./shared"

class PartB
  def self.run
    input = Common::InputReader.real
    @root = Shared::DirectoryTreeParser.parse input
    puts self.find_smallest_folder_thats_big_enough
  end

  def self.find_smallest_folder_thats_big_enough
    @threshold = @root.size - 40_000_000
    @folders_over_threshold = []
    self.find_whether_over_threshold @root
    @folders_over_threshold.push @root.size if @root.size_over @threshold
    @folders_over_threshold.sort.first
  end

  def self.find_whether_over_threshold(element)
    element.children.each do |child|
      next unless child.is_a? Shared::Folder
      self.find_whether_over_threshold child
      @folders_over_threshold.push child.size if child.size_over @threshold
    end
  end
end

PartB.run
