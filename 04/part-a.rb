require "./shared"

all_pairs = retrieve_input
# all_pairs = retrieve_example


pairs_where_one_range_contains_another = all_pairs.filter do |pair| 
    pair_of_ranges = Pair.new pair
    pair_of_ranges.one_range_contains_another_completely
end

p pairs_where_one_range_contains_another.length