require "./shared"
require "pry-rescue"

class PartA
  extend Shared::InputParser
  extend Shared::OutputWriter
  extend Shared::ChallengeExecutor

  def self.execute_instructions
    @instructions.each do |instruction|
      instruction.amount.times do
        @stacks[instruction.to].push(@stacks[instruction.from].pop)
      end
    end
  end
end

PartA.run
