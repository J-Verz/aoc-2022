require_relative './shared'

class FaultyRucksack < Rucksack
  def initialize(raw_contents)
    @first_compartment, @second_compartment = separate_contents(clean_contents(raw_contents))
  end
  
  def separate_contents(contents)
    contents_length = contents.length
    [
      contents[0..(contents_length / 2 - 1)],
      contents[(contents_length / 2)..contents_length]
    ]
  end

  def determine_errors
    errors = Array.new
    @first_compartment.each_char do |char|
      errors.push(char) if @second_compartment.include?(char) && !errors.include?(char)
    end

    errors.map { |item| convert_item_type_to_score item }
  end
end

# contents_of_all_rucksacks = Common::InputReader.example
contents_of_all_rucksacks = Common::InputReader.real

rucksacks = contents_of_all_rucksacks.map do |rucksack_contents|
  FaultyRucksack.new(rucksack_contents)
end

errors = rucksacks.map { |rucksack| rucksack.determine_errors }.flatten
p errors.sum
