require "./shared"

all_pairs = InputReader.real
# all_pairs = InputReader.example


pairs_where_one_range_contains_another = all_pairs.filter do |pair| 
    pair_of_ranges = Pair.new pair
    pair_of_ranges.one_range_contains_another_completely
end

p pairs_where_one_range_contains_another.length