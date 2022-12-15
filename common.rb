# This file contains some commonly used functions
# to improve the DRYness of the repository

def retrieve_lines(filename)
    contents = Array.new
    File.open(filename, "r") { |file|
        contents = file.readlines
    }
    contents
end