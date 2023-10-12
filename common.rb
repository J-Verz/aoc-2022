# This file contains some commonly used functions
# to improve the DRYness of the repository
module Common
  class InputReader
    def self.retrieve_lines(filename)
      pwd = File.dirname(File.expand_path(__FILE__))
      path = File.join pwd, DAY, filename
      contents = File.readlines(path).map(&:chomp)
    end

    def self.example
      self.retrieve_lines('example')
    end

    def self.real
      self.retrieve_lines('input')
    end
  end
end
