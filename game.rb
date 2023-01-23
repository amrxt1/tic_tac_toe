class Board
    attr_accessor :board
    def initialize
        @board = [1,2,3,4,5,6,7,8,9]
    end
end

class Player
    def initialize(name, s)
        @name = name
        @symbol = s
        @score = 0
        @positions_taken = []
    end
end

class Game
    def initialize(players, board)
        @players = players
        @board = board
    end

    def round()
    end
end

module Rules
    
end