# This file contains some commonly used functions
# to improve the DRYness of the repository

def retrieve_lines(filename)
    contents = Array.new
    File.open(filename, "r") { |file|
        contents = file.readlines
    }
    contents.map {|line| line.chomp }
end

def retrieve_example
    retrieve_lines("example")
end

def retrieve_input
    retrieve_lines("input")
end