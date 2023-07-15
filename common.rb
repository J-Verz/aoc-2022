# This file contains some commonly used functions
# to improve the DRYness of the repository

class InputReader
    def self.retrieve_lines(filename)
    contents = Array.new
    File.open(filename, "r") { |file|
        contents = file.readlines
        }
        contents.map {|line| line.chomp }
    end
    
    def self.example
        self.retrieve_lines("example")
    end
    
    def self.real
        self.retrieve_lines("input")
    end
    
end