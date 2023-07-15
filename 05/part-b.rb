require "./shared"
require "pry-rescue"

class PartB
  extend Shared::InputParser
  extend Shared::OutputWriter
  extend Shared::ChallengeExecutor

  def self.execute_instructions
    @instructions.each do |instruction|
      @stacks[instruction.to].add(@stacks[instruction.from].pop_multiple(instruction.amount))
    end
  end
end

PartB.run
