require_relative './shared'

all_pairs = Common::InputReader.real
# all_pairs = Common::InputReader.example


pairs_where_one_range_contains_another = all_pairs.filter do |pair| 
    pair_of_ranges = Pair.new pair
    pair_of_ranges.one_range_contains_another_completely
end

p pairs_where_one_range_contains_another.length