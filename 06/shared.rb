require '../common'

module Shared
    class FIFOBuffer
        attr_accessor :arr
    
        def initialize(size)
            @size = size
            @arr = Array.new
        end
    
        def push(element)
            @arr.push(element)
            @arr.shift if @arr.length > @size
            @arr
        end
    
        def uniq
            obj = self.dup
            obj.arr = @arr.uniq
            obj
        end
    
        def ==(obj)
            @arr == obj.arr
        end
    
        def to_s
            @arr.to_s
        end
    
        def length
            @arr.length
        end
    end
end