class Board
    attr_accessor :board
    def initialize
        @board = [1,2,3,4,5,6,7,8,9]
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

    def reset
        @board = [1,2,3,4,5,6,7,8,9]
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

    def reset
        @positions_taken = []
    end

end

module Rules
    def taken?(position,board)
        !board.board.include?(position)        
    end
    
    def win? (player,board)
        ps = player.positions_taken
        arr_win = [
            [1,2,3],
            [4,5,6],
            [7,8,9],
            [1,4,7],
            [2,5,8],
            [3,6,9],
            [1,5,9],
            [3,5,7]
        ]
        arr_win.each { |y|
            if (y-ps).empty?
                puts player.name+" has won!!"
                player.score += 1
                board.display_board
                return true
            end
        }
        return false
    end

    def draw?(board)
        !board.board.any?{ |b|
            b.is_a? Integer
        }
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
            puts `clear`
            
            @board.board_update((position-1),@players[@@turn].symbol)
            
            tmp = @@turn
            @@turn.even? ? (@@turn += 1) : (@@turn -= 1)


            return [ win?(@players[tmp],@board), draw?(@board)]
            
        end
    end
end




def play_again?
    puts "Do you want to play again? [Y/N]"
    x = gets.chomp.downcase
   if x == 'y'
    return true
   elsif x == 'n'
    puts "Have a great the rest of your day!"
    return false
   else
    puts "Invalid Input!!!! The computer is confused"
    play_again?
   end
end

######################################
puts `clear`
puts "Enter the name for player 1 (x)"
tmp = gets.chomp
#puts "Please select your symbol (X or O)"
#symbol = gets.chomp
p1 = Player.new(tmp, 'x') 

puts `clear`
puts "Enter the name for player 2 (o)"
tmp = gets.chomp
p2 = Player.new(tmp,'o')
board = Board.new

game = Game.new([p1,p2],board)

puts `clear`

loop do
    loop do
        draw, round = game.round()
        if draw
            puts "Its a draw."
            puts "#######SCORE BOARD########"
            puts p1.name+" : "+p1.score.to_s
            puts p2.name+" : "+p2.score.to_s
            break
        end

        if round
            puts "#######SCORE BOARD########"
            puts p1.name+" : "+p1.score.to_s
            puts p2.name+" : "+p2.score.to_s
            break
        end
    end
    if play_again?
        p1.reset
        p2.reset
        board.reset
    else
        break
    end
end


