#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative './shared'
require 'yaml'

class Monkey
  attr_accessor :items
  attr_reader :items_inspected

  def initialize(options)
    @items_inspected = 0

    parse_options options
  end

  def inspect_items
    results = items.map do |worry_level|
      inspect_item worry_level
    end
    items.clear
    results
  end

  private

  def inspect_item(old_worry_level)
    new_worry_level = (do_operation_on(old_worry_level) / 3).floor
    @items_inspected += 1

    {
      :item => new_worry_level,
      :destination => test(new_worry_level)
    }
  end

  def do_operation_on(old)
    eval @operation
  end

  def test(worry_level)
    if passes_test? worry_level
      @true_destination
    else
      @false_destination
    end
  end

  def passes_test?(value)
    value % @test_value == 0
  end

  def parse_options(options)
    options.each do |key, value|
      case key
      when :"Starting items"
        @items = value.to_s.split(', ').map(&:to_i)
      when :"Operation"
        @operation = value
      when :"Test"
        @test_value = value.split.last.to_i
      when :"If true"
        @true_destination = value.split.last.to_i
      when :"If false"
        @false_destination = value.split.last.to_i
      else
        raise "Unparseable setting: '#{key}' => '#{value}'"
      end
    end
  end

end

class PartA
  def self.run
    input = load_input
    @monkeys = input.map do |name, opts|
      Monkey.new opts
    end

    20.times do 
      a_round
    end
    
    puts result
  end

  private

  def self.load_input
    yaml_input = 
    Common::InputReader
      .real
      .whole
      .gsub(/  If/, 'If')
    
    YAML.load(
      yaml_input,
      symbolize_names: true)
  end

  def self.a_round
    @monkeys.each do |monkey|
      decisions = monkey.inspect_items
      decisions.each do |decision|
        give decision[:item], to: decision[:destination]
      end
    end
  end

  def self.give(item, to:)
    @monkeys[to].items.push item
  end

  def self.result
    items_inspected_per_monkey_sorted
      .last(2) # get two highest amounts
      .reduce(:*) # multiply
  end

  def self.items_inspected_per_monkey_sorted
    @monkeys.map(&:items_inspected).sort
  end
end

if __FILE__ == $0
  PartA.run
end
