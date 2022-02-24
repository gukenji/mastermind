require 'colorize'
require_relative 'texts.rb'

module Player
    extend Texts
    @@score = 0 

    def player_types(number)
        {1 => "Adivinhador".bold,
         2 => "Criador do Código".bold   
        }[number]
    end

    def create_players
        @player = {
        type: nil,
        score: 0,
        attempt: 0,
        combination: Array.new(4)
        }
        @computer = {
        type: nil,
        score: 0,
        attempt: 0,
        combination: Array.new(4)
        }
    end



end


