require_relative './shared'

all_pairs = Common::InputReader.real
# all_pairs = Common::InputReader.example


pairs_which_overlap = all_pairs.filter do |pair| 
    pair_of_ranges = Pair.new pair
    pair_of_ranges.ranges_overlap
end

p pairs_which_overlap.length