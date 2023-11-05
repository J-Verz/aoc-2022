# This file contains some commonly used functions
# to improve the DRYness of the repository
module Common
  class InputReader
    attr_writer :filename

    def self.file_path
      pwd = File.dirname(File.expand_path(__FILE__))
      File.join pwd, DAY, @filename
    end

    def self.example
      @filename = 'example'
      self
    end

    def self.real
      @filename = 'input'
      self
    end

    def self.per_line
      File.readlines(file_path).map(&:chomp)
    end

    def self.per_character
      per_line.map {|line| line.split '' }
    end

    def self.whole
      File.read(file_path)
    end
  end
end
