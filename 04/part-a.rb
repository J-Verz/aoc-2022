require_relative './shared'

all_pairs = Common::InputReader.real.per_line
# all_pairs = Common::InputReader.example.per_line


pairs_where_one_range_contains_another = all_pairs.filter do |pair| 
    pair_of_ranges = Pair.new pair
    pair_of_ranges.one_range_contains_another_completely
end

p pairs_where_one_range_contains_another.length