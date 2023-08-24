# This file contains some commonly used functions
# to improve the DRYness of the repository
module Common
  class InputReader
    def self.retrieve_lines(filename)
      contents = File.readlines(filename).map(&:chomp)
    end

    def self.example
      self.retrieve_lines('example')
    end

    def self.real
      self.retrieve_lines('input')
    end
  end
end
