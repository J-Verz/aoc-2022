require "./shared"
require "pry"

# sections_per_pair = retrieve_input
sections_per_pair = retrieve_example

def first_contains_second(pair)
    pair[0][:start] <= pair[1][:start] && pair[0][:end] >= pair[1][:end]
end

def second_contains_first(pair)
    pair[0][:start] >= pair[1][:start] && pair[0][:end] <= pair[1][:end]
end

sections_per_pair_per_elf = sections_per_pair.map do |pair| 
    pair_per_elf = pair.chomp.split(",")
    binding.pry
    parsed_pair = pair_per_elf.map do |range|
        binding.pry
        s, e = range.split("-")
        {
            :start => s,
            :end => e
        }
    end
    binding.pry if parsed_pair[0] = ""
    1 if second_contains_first(parsed_pair)
    1 if first_contains_second(parsed_pair)
    0
end

p sections_per_pair_per_elf
p sections_per_pair_per_elf.sum