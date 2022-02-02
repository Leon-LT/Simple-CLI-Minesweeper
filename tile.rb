class Tile
    def initialize(position, grid, bombed? = false)
        @flagged? = false
        @bombed? = bombed?
        @revealed? = false
        @nearest_bomb = 0
        @position = position
        @grid = grid
    end

    def flag
        @flagged? = @flagged? ? false : true 
    end

    def reveal
        @revealed? = @revealed? ? false : true 
    end

    def neighbours
        neighbours_tiles = []
        #finire metodo, deve salvare tutte le tile vicine nell'array
    end

end