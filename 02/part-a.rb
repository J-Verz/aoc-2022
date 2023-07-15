require './shared'

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

rounds = Common::InputReader.real
rounds.map! do |round|
    Round.new(round).determine_score
end
puts rounds.sum