#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative './shared'

class CRTScreen
  def initialize
    @screen = Array.new 6*40, false
  end

  def set(index) 
    @screen[index] = true
  end

  def render
    until (row = @screen.slice!(0...40)).empty?
      puts (row.map do |pixel|
        if pixel
          '#'
        else
          '.'
        end
      end).join
    end
  end
end

class PartB
  def self.run
    @counter = 0
    @xRegister = 1
    @crt = CRTScreen.new
    input = Common::InputReader.real
    input.each do |instruction|
      command, parameter = instruction.split(' ')
      self.send(command, parameter)
    end
    @crt.render
  end

  private

  def self.noop(ignore)
    increment_counter_and_set_pixel
  end

  
  def self.addx(value)
    increment_counter_and_set_pixel
    increment_counter_and_set_pixel
    @xRegister += value.to_i
  end

  def self.increment_counter_and_set_pixel
    set_pixel if sprite_covers_current_pixel
    increment_counter
  end

  def self.sprite_covers_current_pixel
    ((@counter % 40) - @xRegister).abs <= 1
  end

  def self.set_pixel
    @crt.set @counter
  end
  
  def self.increment_counter
    @counter += 1
  end
end

if __FILE__ == $0
  PartB.run
end
