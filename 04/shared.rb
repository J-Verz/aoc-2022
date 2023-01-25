require "../common"

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

    def one_range_contains_another_completely
        true if first_contains_second or second_contains_first
    end

    def ranges_overlap
        true if end_of_first_overlaps_with_second or end_of_second_overlaps_with_first
    end

    private

    def first_contains_second
        @first.start <= @second.start and @first.end >= @second.end
    end

    def second_contains_first
        @first.start >= @second.start and @first.end <= @second.end
    end

    def end_of_first_overlaps_with_second
        @first.end >= @second.start and @first.start <= @second.start
    end

    def end_of_second_overlaps_with_first
        @second.end >= @first.start and @second.start <= @first.start
    end
end