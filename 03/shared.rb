require_relative '../common'

DAY = '03'

class Rucksack
  attr_reader :contents

  def initialize(raw_contents)
    @contents = clean_contents(raw_contents)
  end

  def clean_contents(raw_contents)
    raw_contents.gsub(/\n/, "")
  end

  def include?(char)
    @contents.include?(char)
  end

  def full_contents
    [
      @first_compartment,
      @second_compartment,
    ]
  end
end

def convert_item_type_to_score(item)
    item.match(/[a-z]/) ? item.codepoints[0] - 96 : item.codepoints[0] - 38
end
