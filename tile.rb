require "byebug"
class Tile
    attr_reader :grid, :bombed
    def initialize(position, grid)
        @flagged = false
        @bombed = false
        @revealed = false
        @neighbours_number = 0
        @position = position
        @grid = grid
    end

    def inspect
        { "position" => @position, "bombed" => @bombed}.inspect
    end

    def toggle_flag
        @flagged = @flagged ? false : true 
    end

    def reveal
        @revealed = @revealed ? false : true 
    end

    def is_bomb
        @bombed = @bombed ? false : true 
    end

    def neighbours
        neighbours_coords = [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]
        neighbours_arr = []

        neighbours_coords.each do |coords|
            x,y = coords
            curr_x,curr_y = @position
            neighbours_arr << @grid[[x + curr_x,y + curr_y]]
        end
        neighbours_arr
    end

    def neighbour_bombs_count
        bomb_count = 0
        neighbours.each do |tile| 
            bomb_count += 1 if tile.bombed
        end
        bomb_count
    end

    
end