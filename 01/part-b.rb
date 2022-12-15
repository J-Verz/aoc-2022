require './common'

puts calc_calories_per_elf
        .sort
        .values_at(-1, -2, -3)
        .map! {|el| el.to_i }
        .sum