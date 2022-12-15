require '../common'

SCORES = {
    'win' => 6,
    'draw' => 3,
    'loss' => 0,
}


class Shape
    def initialize(score)
        @score = score
    end

    def ==(other_shape)
        self.class == other_shape.class
    end

    attr_reader :score
end

class Rock < Shape
    def initialize
        super(1)
    end

    def beats?(other_shape)
        (other_shape.class == Scissors) ? true : false
    end
end

class Paper < Shape
    def initialize
        super(2)
    end

    def beats?(other_shape)
        (other_shape.class == Rock) ? true : false
    end
end

class Scissors < Shape
    def initialize
        super(3)
    end

    def beats?(other_shape)
        (other_shape.class == Paper) ? true : false
    end
end

class Round
    def initialize(round_description)
        (@opponents_choice, @your_choice) = round_description.split(" ").map do |letter|
            case letter
            in "A" | "X"
                Rock.new
            in "B" | "Y"
                Paper.new
            in "C" | "Z"
                Scissors.new
            else
                puts "Found weird character: \"#{letter}\". Exiting"
                exit!
            end
        end
    end

    def determine_outcome
        if @opponents_choice == @your_choice
            "draw"
        elsif @opponents_choice.beats?(@your_choice)
            "loss"
        else
            "win"
        end
    end

    def determine_score
        outcome = determine_outcome
        @score = 
            @your_choice.score +
            SCORES[outcome]
    end

end

rounds = retrieve_lines("input")
rounds.map! do |round|
    Round.new(round).determine_score
end
puts rounds.sum