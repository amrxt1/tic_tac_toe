class Board
    attr_accessor :board
    def initialize
        @board = [1,'x',3,4,5,6,7,8,9]
    end

    def display_board()
        j = 0
        for i in 0..8 do
            if @board[i].is_a? Integer
                print "_ "
            else
                print @board[i]+" "
            end

            if j == 2
                puts ""
                j = 0
            else
                j+=1
            end
        end
    end

    def board_update(position, symbol)
        self.board[position] = symbol
    end

end

class Player
    attr_accessor :name,:symbol,:score,:positions_taken
    def initialize(name, s)
        @name = name
        @symbol = s
        @score = 0
        @positions_taken = []
    end
end

module Rules
    def taken?(position,board)
        !board.board.include?(position)        
    end
    
end

class Game
    include Rules
    
    @@turn = rand(2)
    def initialize(players, board)
        @players = players
        @board = board
    end
    
    def round()
        @board.display_board()
        
        puts @players[@@turn].name+"'s turn, enter the position you wish to take (1-9)"
        position = gets[0].chomp.to_i

        if taken?(position, @board)
            puts "position already taken"
            round()
        else
            @players[@@turn].positions_taken.push(position)
            pp @players

            @board.board_update((position-1),@players[@@turn].symbol)
        end
    end
end



#puts "Enter the name for player 1"
#tmp = gets.chomp
#puts "Please select your symbol (X or O)"
#symbol = gets.chomp
p1 = Player.new('play1', 'x')

p2 = Player.new('play2','o')
board = Board.new

game = Game.new([p1,p2],board)
game.round()