require "../common"

module Shared
  class DirectoryTreeParser
    def self.parse(input)
      input.each do |line|
        case line
        when /^\$\scd\s(?<name>.+)$/
          folder_name = $~[:name]
          case folder_name
          when "/" # if name is '/', create Root
            @current_folder = @root = Shared::Root.new
          when ".." # if name is '..', move to parent folder
            @current_folder = @current_folder.parent
          else # else, change context to specified folder
            @current_folder = @current_folder.child folder_name
          end
        when /^\$\sls$/
          # listing folder inputs, read to create content.
          # Doesn't have to do anything
        when /^(?<size>\d+)\s(?<name>.+)$/
          file_size = $~[:size].to_i
          file_name = $~[:name]
          @current_folder.add_child Shared::File.new(file_name, file_size)
        when /^dir\s(?<name>.+)$/
          folder_name = $~[:name]
          Shared::Folder.new(folder_name, @current_folder)
        else
          raise "This line,\n'#{line}'\nis not recognized."
        end
      end
      @root
    end
  end

  class Folder
    attr_reader :parent, :name

    def initialize(name, parent)
      @name = name
      @parent = parent
      parent.add_child self
      @children = {}
    end

    def add_child(element)
      @children[element.name] = element
    end

    def size
      @size ||= children.map(&:size).sum
    end

    def child(name)
      @children[name]
    end

    def size_under_100_001?
      size <= 100_000
    end

    def children
      @children.values
    end
  end

  class Root < Folder
    def initialize
      @name = "/"
      @children = {}
    end

    def parent
      raise "The Root folder does not have a parent"
    end
  end

  class File
    attr_reader :size, :name

    def initialize(name, size)
      @name = name
      @size = size
    end
  end
end
