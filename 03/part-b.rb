require "./shared"

class Group
  attr_reader :common_item

  def initialize(rucksacks)
    @rucksacks = rucksacks
  end

  def determine_common_item
    @rucksacks[0].contents.each_char do |char|
      if @rucksacks[1].include?(char) and @rucksacks[2].include?(char)
        @common_item = char
        break
      end
    end
  end
end

# contents_of_all_rucksacks = InputReader.example
contents_of_all_rucksacks = InputReader.real
groups = Array.new
while contents_of_all_rucksacks.length > 0
  group_contents = contents_of_all_rucksacks.shift(3)
  group = Group.new (group_contents.map! do |rucksack_contents|
    Rucksack.new(rucksack_contents)
  end)
  groups.push(group)
end

groups.map! do |group|
  group.determine_common_item
  convert_item_type_to_score(group.common_item)
end

p groups.sum