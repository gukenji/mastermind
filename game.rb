require_relative 'texts.rb'
require_relative 'player.rb'

class Game
    extend Texts 
    include Player

    def initialize
        puts Texts.initial_instructions
        choose_sides
        create_combination(@player[:type])
        @player[:type] == 1 ? player_decision(@player) : player_decision(@computer)
        @player[:type] == 1 ? process_attempts(@player) : process_attempts(@computer)

        puts ""
        puts "Deseja jogar novamente?"
        puts "1 - SIM"
        puts "2 - NÃO"
        @@play_again = gets.chomp.to_i
        play_again(@@play_again)
    end
     

    def process_attempts(player)
        until player[:attempt] == 12 || feedback(player[:combination])
            puts "Combinação errada. Nova tentativa.".bold
            puts " "
            @player[:type] == 1 ? player_decision(@player) : player_decision(@computer)
            if player[:attempt] == 12 && feedback(player[:combination]) == false
                puts " "
                puts "=========================================="
                puts "              Você perdeu!".bold
                puts "A combinação correta era: #{Texts.player_combination(@new_combination)}"
                puts "=========================================="
            end
        end
    end

    def choose_sides
        create_players
        puts Texts.player_choice
        @player[:type] = gets.chomp.delete(' ').to_i
        until (@player[:type] == 1) || (@player[:type] == 2)
            puts "Código de jogador incorreto." 
            puts Texts.player_choice
            @player[:type] = gets.chomp.delete(' ').to_i
        end
        
        @player[:type] == 1 ? @computer[:type] = 2 : @computer[:type] = 1
        puts "Ok! Você será o #{player_types(@player[:type])} e o PC será #{player_types(@computer[:type])}"
    end

    def create_combination(side)
        @new_combination = []
        case side
        when 1 
            until @new_combination.length == 4
                @new_combination.push(Random.rand(1..6))
            end
        when 2
            puts "Escolha uma combinação de 4 números, sendo eles de 1 até 6. Digite-os separando por espaço"
            @new_combination = gets.chomp.split(' ').map(&:to_i)
            until combination_valid?(@new_combination)
                @new_combination = gets.chomp.split(' ').map(&:to_i)
            end
            puts "Ok! A combinação criada é: #{Texts.player_combination(@new_combination)}"
        end
    end

    def player_decision(player)
        case player
        when @player
            puts "Escolha uma combinação de 4 números. Escreva cada número separado por um espaço."
            @player[:combination] = gets.chomp.split(' ').map(&:to_i)
            until combination_valid?(@player[:combination])
                @player[:combination] = gets.chomp.split(' ').map(&:to_i)
            end
            @player[:attempt]+=1
            puts "Números escolhidos por você: #{Texts.player_combination(@player[:combination])}"
            puts "Tentativa #{@player[:attempt]} de 12"
        when @computer
            @computer[:combination].each_index do |index|
                if @computer[:combination][index] == @new_combination[index]
                    @computer[:combination][index]
                else
                    @computer[:combination][index] = Random.rand(1..6)
                end
            end    
            @computer[:attempt] +=1
            puts "Números escolhidos pelo computador: #{Texts.player_combination(@computer[:combination])}"
            puts "Tentativa #{@computer[:attempt]} de 12"
        end
        
    end

    def combination_valid?(array)
        if array.length != 4 
            puts "Você precisa escolher 4 números! Digite novamente, separando cada número com um espaço."
            return false
        elsif array.any? {|e| e < 1 || e > 6}
            puts "Os números só podem ser de 1 até 6! Escolha novamente, separando cada número com um espaço."
            return false
        else
            return true
        end
    end


    def feedback(array)
        @@correct_choices = 0
            array.each do |e|
                @new_combination.include?(e) ? @@correct_choices +=1 : next
            end
        @@colored_dots = 0
        @@white_dots = 0
        array.length.times do |e|
            if array[e].to_i == @new_combination[e]
                @@colored_dots +=1
            end
        end
        @@white_dots = @@correct_choices - @@colored_dots 
        if @@colored_dots == 4 
            puts " "
            puts "======================"
            puts "Parabens, você ganhou!".bold
            puts "======================"
            return true
        else
            print "FEEDBACK: "
            @@white_dots.times do 
                print Texts.feedback_dots(:white)
            end
            @@colored_dots.times do 
                print Texts.feedback_dots(:colored)
            end
            puts " "
            return false
        end
    end
    
    def play_again(type)
        type == 1 ? Game.new : puts("Obrigado por jogar!")
    end

end

