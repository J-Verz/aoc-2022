# frozen_string_literal: true
require_relative '../common'
require 'pry-rescue'

DAY = "10"

module Shared
    module Instructions
        def noop(ignore)
            increment_counter
        end

        def addx(value)
            increment_counter
            increment_counter
            @xRegister += value.to_i
        end
    end

    module Counter
        def increment_counter
            before_counter_increment
            @counter += 1
            after_counter_increment
        end

        def before_counter_increment
            raise 'before_counter_increment not implemented'
        end

        def after_counter_increment
            raise 'after_counter_increment not implemented'
        end
    end
end
