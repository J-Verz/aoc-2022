def retrieve_lines(filename)
    contents = Array.new
    File.open(filename, "r") { |file|
        contents = file.readlines
    }
    contents
end

def calc_calories_per_elf
    contents = retrieve_lines("example")
    contents = retrieve_lines("input")
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