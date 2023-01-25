require "./shared"

sections_per_pair = retrieve_input
# sections_per_pair = retrieve_example

def start_of_first(pair)
    pair[0][:start]
end

def start_of_second(pair)
    pair[1][:start]
end

def end_of_first(pair)
    pair[0][:end]
end

def end_of_second(pair)
    pair[1][:end]
end

def first_contains_second(pair)
    start_of_first(pair) <= start_of_second(pair) && end_of_first(pair) >= end_of_second(pair)
end

def second_contains_first(pair)
    start_of_first(pair) >= start_of_second(pair) && end_of_first(pair) <= end_of_second(pair)
end

sections_per_pair_per_elf = sections_per_pair.filter do |pair| 
    pair_per_elf = pair.split(",")
    parsed_pair = pair_per_elf.map do |range|
        s, e = range.split("-").map { |bound| bound.to_i }
        {
            :start => s,
            :end => e
        }
    end
    true if second_contains_first(parsed_pair) || first_contains_second(parsed_pair)
end

p sections_per_pair_per_elf.length