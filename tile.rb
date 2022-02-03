class Tile
    def initialize(position, grid, bombed = false)
        @flagged = false
        @bombed = bombed
        @revealed = false
        @neighbours_number = 0
        @position = position
        @grid = grid
    end

    def toggle_flag
        @flagged = @flagged ? false : true 
    end

    def reveal
        @revealed = @revealed ? false : true 
    end

    def neighbours
        neighbours_coords = [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]
        neighbours = []

        neighbours_coords.each do |coords|
            x,y = coords
            curr_x,curr_y = @position
            puts x + curr_x
            puts y + curr_y
            puts "--------"
            neighbours << @grid[x + curr_x][y + curr_y]
        end
    end
end