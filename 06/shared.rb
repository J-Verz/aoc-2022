require_relative '../common'

DAY = '06'

module Shared
  class FIFOBuffer
    attr_accessor :arr

    def initialize(size)
      @size = size
      @arr = Array.new
    end

    def push(element)
      @arr.push(element)
      @arr.shift if @arr.length > @size
      @arr
    end

    def uniq
      obj = self.dup
      obj.arr = @arr.uniq
      obj
    end

    def ==(obj)
      @arr == obj.arr
    end

    def length
      @arr.length
    end
  end

  module MarkerFinder
    def find_marker(length)
      @marker_length = length
      input = Common::InputReader.real.first.chars
      @buffer = Shared::FIFOBuffer.new(length)
      input.each_with_index do |char, index|
        @buffer.push char
        next unless self.check_buffer
        puts index + 1
        break
      end
    end

    def check_buffer
      @buffer.length == @marker_length && @buffer.uniq == @buffer
    end
  end
end
