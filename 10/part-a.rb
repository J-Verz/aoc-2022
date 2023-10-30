#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative './shared'


class PartA
  IMPORTANT_CYCLES = [20, 60, 100, 140, 180, 220]

  def self.run
    input = Common::InputReader.real
    @result = 0
    @counter = 0
    @xRegister = 1
    input.each do |instruction|
      command, parameter = instruction.split(' ')
      send(command, parameter)
    end
    puts @result
  end

  private

  def self.noop(ignore)
    puts 'doing nothing'
    increment_and_check_counter
  end

  
  def self.addx(value)
    increment_and_check_counter
    increment_and_check_counter
    @xRegister += value.to_i
    puts "adding #{value}"
  end

  def self.increment_and_check_counter
    increment_counter
    save_register_state if check_if_counter_at_important_value
  end

  def self.increment_counter
    @counter += 1
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
