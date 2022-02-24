require 'colorize'

module Texts
    def self.colors(number)
        {
           1 => " 1 ".white.on_red,
           2 => " 2 ".white.on_blue,
           3 => " 3 ".white.on_black,
           4 => " 4 ".white.on_magenta,
           5 => " 5 ".white.on_cyan,
           6 => " 6 ".white.on_green
        }[number]
      end

        
    def self.initial_instructions
        <<~HEREDOC
        #{"============================================================== Bem vindo ao jogo MasterMind!  ==============================================================".bold}

        #{"COMO O JOGO FUNCIONA:".italic}
        Este é um jogo em que o objetivo é você (ou o computador) precisa adivinhar um código de 4 números, sendo que existem 6 números possíveis, sendo eles: #{colors(1)} #{colors(2)} #{colors(3)} #{colors(4)} #{colors(5)} #{colors(6)}

        A cada tentativa de decifrar o código será retornado um feedback, contendo os seguintes possíveis retornos:
            a. ● : significa que você acertou um número e a posição relativo a este número;
            b. ○ : significa que você acertou um número, mas errou a posição relativa a este número;
            c. Vazio: significa que você não acertou nenhum possível número que possa estar na combinação.

        #{"Exemplo:".italic}
            COMBINAÇÃO:  #{colors(1)} #{colors(2)} #{colors(2)} #{colors(4)}
            1o PALPITE:  #{colors(1)} #{colors(5)} #{colors(3)} #{colors(2)}
            FEEDBACK: ● ○ (1 cor certa no local certo e 1 cor certa no local errado)
            ============================================================================
            2o PALPITE:  #{colors(1)} #{colors(2)} #{colors(3)} #{colors(2)}
            FEEDBACK: ● ● ○ (2 cores certas no local certo e 1 cor certa no local errado)

        #{"REGRAS:".italic}
            1. O adivinhador terá 12 tentativas para descobrir o código;
            2. Existem apenas 6 variações de números (1 até 6);
            3. O código pode haver número repetido;
            4. Caso o adivinhador vença, ele receberá +1 ponto. Do contrário o criador do código receberá 1 ponto.
            5. Você definirá a quantidade de pontos que é necessário um jogador atingir para o jogo terminar.
        
        #{"==================================================================  Se divirta! ==================================================================".bold}

        HEREDOC
    end

    def self.player_choice
        <<~HEREDOC
        Por favor, digite o tipo de jogador que deseja ser.
        1: adivinhador
        2: criador do código
        HEREDOC
    end

    def self.player_combination(array)
        text = ""
        array.map do |e|
            text << self.colors(e.to_i) + " "
        end
        return text
    end

    def self.feedback_dots(type)
        types = {colored: "● ",
         white: "○ "
        }
        return types[type]
    end


end

