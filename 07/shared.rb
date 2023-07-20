require "../common"

module Shared
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
