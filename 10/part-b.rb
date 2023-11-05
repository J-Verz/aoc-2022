#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative './shared'

class CRT
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
  extend Shared::Instructions
  extend Shared::Counter

  def self.run
    @counter = 0
    @xRegister = 1
    @crt = CRT.new
    input = Common::InputReader.real.per_line
    input.each do |instruction|
      command, parameter = instruction.split(' ')
      send(command, parameter)
    end
    @crt.render
  end

  private

  def self.before_counter_increment
    set_pixel if sprite_covers_current_pixel
  end
  
  def self.after_counter_increment; end

  def self.sprite_covers_current_pixel
    ((@counter % 40) - @xRegister).abs <= 1
  end

  def self.set_pixel
    @crt.set @counter
  end
end

if __FILE__ == $0
  PartB.run
end
