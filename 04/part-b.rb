require_relative './shared'

all_pairs = Common::InputReader.real.per_line
# all_pairs = Common::InputReader.example.per_line


pairs_which_overlap = all_pairs.filter do |pair| 
    pair_of_ranges = Pair.new pair
    pair_of_ranges.ranges_overlap
end

p pairs_which_overlap.length