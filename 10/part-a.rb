#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative './shared'


class PartA
  extend Shared::Instructions
  extend Shared::Counter

  IMPORTANT_CYCLES = [20, 60, 100, 140, 180, 220]

  def self.run
    @result = 0
    @counter = 0
    @xRegister = 1
    input = Common::InputReader.real
    input.each do |instruction|
      command, parameter = instruction.split(' ')
      send(command, parameter)
    end
    puts @result
  end

  private

  def self.before_counter_increment; end

  def self.after_counter_increment
    save_register_state if check_if_counter_at_important_value
  end

  def self.check_if_counter_at_important_value
    IMPORTANT_CYCLES.include? @counter
  end

  def self.save_register_state
    @result += @xRegister * @counter
  end
end

if __FILE__ == $0
  PartA.run
end
