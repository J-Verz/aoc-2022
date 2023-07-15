require '../common'

def calc_calories_per_elf
    # contents = InputReader.example
    contents = InputReader.real
    calories_per_elf = Array.new
    calories_of_current_elf = 0
    while contents.length > 0 do
        current_line = contents.shift
        if current_line.length == 1
            calories_per_elf.push(calories_of_current_elf)
            calories_of_current_elf = 0
            next
        end
        calories_of_current_elf += current_line.to_i
    end
    calories_per_elf
end