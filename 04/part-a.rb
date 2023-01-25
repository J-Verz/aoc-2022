require "./shared"

all_pairs = retrieve_input
# all_pairs = retrieve_example

class Range
    attr_reader :start, :end

    def initialize(unparsed_range)
        @start, @end = unparsed_range.split("-").map {|bound| bound.to_i}
    end
end

class Pair
    def initialize(unparsed_pair)
        @first, @second = unparsed_pair.split(",").map do |range|
            Range.new range
        end
    end

    def one_range_contains_another
        true if first_contains_second or second_contains_first
    end

    private

    def first_contains_second
        @first.start <= @second.start && @first.end >= @second.end
    end

    def second_contains_first
        @first.start >= @second.start && @first.end <= @second.end
    end
end


pairs_where_one_section_contains_another = all_pairs.filter do |pair| 
    pair_of_ranges = Pair.new pair
    pair_of_ranges.one_range_contains_another
end

p pairs_where_one_section_contains_another.length