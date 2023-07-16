require './shared'
require 'pry-rescue'

class PartA
    def self.run
        input = Common::InputReader.real.first.chars
        @buffer = Shared::FIFOBuffer.new(4)
        input.each_with_index do |char, index|
            @buffer.push char
            next unless self.check_buffer
            puts index+1
            break
        end

    end

    def self.check_buffer
        @buffer.length == 4 && @buffer.uniq == @buffer
    end
end

PartA.run