class Tile
    def initialize(position, grid, bombed? = false)
        @flagged? = false
        @bombed? = bombed?
        @revealed? = false
        @neighbours_number = 0
        @position = position
        @grid = grid
    end
end