require "./shared"

all_pairs = retrieve_input
# all_pairs = retrieve_example


pairs_which_overlap = all_pairs.filter do |pair| 
    pair_of_ranges = Pair.new pair
    pair_of_ranges.ranges_overlap
end

p pairs_which_overlap.length