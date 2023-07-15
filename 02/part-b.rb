require './shared'

class Round
    def initialize(round_description)
        (@opponents_choice, @outcome) = round_description.split(" ").map do |letter|
            case letter
            in "A"
                Rock.new
            in "B"
                Paper.new
            in "C"
                Scissors.new
            in "X"
                "loss"
            in "Y"
                "draw"
            in "Z"
                "win"
            else
                puts "Found weird character: \"#{letter}\". Exiting"
                exit!
            end
        end
    end

    def determine_my_choice
        if @outcome == "win"
            @opponents_choice.superior_shape.new
        elsif @outcome == "draw"
            @opponents_choice.class.new
        else
            @opponents_choice.inferior_shape.new
        end
    end

    def determine_score
        your_choice = determine_my_choice
        @score = 
            your_choice.score +
            SCORES[@outcome]
    end

    attr_reader :outcome, :opponents_choice
end

rounds = Common::InputReader.real
rounds.map! do |round|
    Round.new(round).determine_score
end
puts rounds.sum