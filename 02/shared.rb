require '../common'


SCORES = {
    'win' => 6,
    'draw' => 3,
    'loss' => 0,
}


class Shape
    def initialize(score, inferior_shape, superior_shape)
        @score = score
        @inferior_shape = inferior_shape
        @superior_shape = superior_shape
    end

    def ==(other_shape)
        self.class == other_shape.class
    end

    attr_reader :score, :superior_shape, :inferior_shape
end

class Rock < Shape
    def initialize
        super(1, Scissors, Paper)
    end

    def beats?(other_shape)
        (other_shape.class == @inferior_shape) ? true : false
    end
end

class Paper < Shape
    def initialize
        super(2, Rock, Scissors)
    end

    def beats?(other_shape)
        (other_shape.class == @inferior_shape) ? true : false
    end
end

class Scissors < Shape
    def initialize
        super(3, Paper, Rock)
    end

    def beats?(other_shape)
        (other_shape.class == @inferior_shape) ? true : false
    end
end
