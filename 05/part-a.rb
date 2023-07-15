require './shared'
require 'pry-rescue'

class PartA
    def self.run
        # Get input and parse to data model
        self.parse_input retrieve_input
        # Execute instructions
        self.execute_instructions
        # Tell elves which crates are on top
        self.find_top_crates
    end

    def self.parse_input(input)
        self.initial_configuration(input).each do |line|
            case line
            when /(\s+[0-9])+/
                self.create_stacks line
            when /\s+(\[[A-Z]\])+\s+/
                self.create_crates_on_stack line
            else
                raise "The following line is invalid:\n'#{line}'"
            end
        end

        @@instructions = self.instructions(input).map do |line|
            ::Instruction.new line
        end
        
    end

    def self.execute_instructions
        @@instructions.each do |instruction|
            instruction.amount.times do
                @@stacks[instruction.to].push(@@stacks[instruction.from].pop)
            end
        end
    end

    def self.find_top_crates
        @@stacks.each_value.map {|stack| stack.top.identifier }.join
    end

    private

    def self.create_stacks(line)
        @@stacks = {}
        line.scan(/[0-9]/) do |number|
            @@stacks[number.to_i] = ::StackOfCrates.new number.to_i
        end
    end

    def self.create_crates_on_stack(line)
        @@stacks.length.times do |i|
            line_piece = line[i*4..i*4+3]
            next unless line_piece.include? "["
            line_piece.scan(/[A-Z]/) do |crate_id|
                @@stacks[i+1].push ::Crate.new crate_id
            end
        end
    end

    def self.split_point(input)
        input.find_index {|i| i == "" }
    end

    def self.initial_configuration(input)
        input[0..self.split_point(input)-1].reverse!
    end

    def self.instructions(input)
        input[self.split_point(input)+1..-1]
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

puts PartA.run
