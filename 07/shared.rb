require '../common'

module Shared
    

    class Root
        def initialize
            @children = []
        end

        def add_child(element)
            @children.push element
        end

        def size
            @children.map(&:size).sum
        end

        def name
            '/'
        end

        def parent
            raise 'The Root folder does not have a parent'
        end
    end

    class Folder
        attr_reader :parent
        def initialize(name, parent = nil)
            @name = name
            @parent = parent
            parent.add_child self
            @children = []
        end

        def add_child(element)
            @children.push element
        end

        def size
            @children.map(&:size).sum
        end
    end
    
    class File
        attr_reader :size
        def initialize(name, size)
            @name = name
            @size = size
        end
    end
end