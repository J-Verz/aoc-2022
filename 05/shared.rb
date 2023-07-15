require "../common"

module Shared
  module ChallengeExecutor
    def run
      # Get input and parse to data model
      self.parse_input InputReader.example
      # Execute instructions
      self.execute_instructions
      # Tell elves which crates are on top
      puts self.find_top_crates
    end
  end

  module InputParser
    def parse_input(input)
      initial_configuration(input).each do |line|
        case line
        when /(\s+[0-9])+/
          create_stacks line
        when /\s+(\[[A-Z]\])+\s+/
          create_crates_on_stack line
        else
          raise "The following line is invalid:\n'#{line}'"
        end
      end

      @instructions = instructions(input).map do |line|
        Instruction.new line
      end
    end

    private

    def create_stacks(line)
      @stacks = {}
      line.scan(/[0-9]/) do |number|
        @stacks[number.to_i] = StackOfCrates.new number.to_i
      end
    end

    def create_crates_on_stack(line)
      @stacks.length.times do |i|
        line_piece = line[i * 4..i * 4 + 3]
        next unless line_piece.include? "["
        line_piece.scan(/[A-Z]/) do |crate_id|
          @stacks[i + 1].push Crate.new crate_id
        end
      end
    end

    def split_point(input)
      input.find_index { |i| i == "" }
    end

    def initial_configuration(input)
      input[0..split_point(input) - 1].reverse!
    end

    def instructions(input)
      input[split_point(input) + 1..-1]
    end
  end

  module OutputWriter
    def find_top_crates
      @stacks.each_value.map { |stack| stack.top.identifier }.join
    end
  end

  class Instruction
    attr_reader :amount, :from, :to, :full

    def initialize(complete_instruction)
      @full = complete_instruction
      numbers = complete_instruction.scan(/[0-9]+/).map(&:to_i)

      @amount = numbers[0]
      @from = numbers[1]
      @to = numbers[2]
    end
  end

  class Crate
    attr_reader :identifier

    def initialize(identifier)
      @identifier = identifier
    end
  end

  class StackOfCrates
    def initialize(number)
      @number = number
      @crates = []
    end

    def push(crate)
      @crates.push crate
    end

    def pop
      @crates.pop
    end

    def top
      @crates.last
    end
  end
end
