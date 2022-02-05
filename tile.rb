require "byebug"
class Tile
    attr_reader :bombed, :flagged
    attr_accessor :near_bombs, :revealed
    def initialize(position, grid)
        @flagged = false
        @bombed = false
        @revealed = false
        @position = position
        @grid = grid
    end

    def inspect
        { "position" => @position, "revealed" => @revealed, "bombed" => @bombed}.inspect
    end

    def toggle_flag
        @flagged = @flagged ? false : true 
    end

    def reveal
        return if @revealed || @bombed
        self.revealed = true
        if neighbors.none? { |neighbor| neighbor.bombed}
            neighbors.each do |neighbor| 
                neighbor.reveal
            end
        end
    end

    def is_bomb
        @bombed = @bombed ? false : true 
    end

    def neighbors
        neighbors_coords = [[-1,0], [1,0], [0,-1], [0,1], [-1,-1], [-1,1], [1,-1], [1,1]]
        neighbors_arr = []

        neighbors_coords.each do |coords|
            x, y = (@position[0] + coords[0]), (@position[1] + coords[1])
            neighbor_pos = [x, y]

            if neighbor_pos.all? { |coord| coord.between?(0,( @grid.grid_size - 1)) }
                neighbors_arr << @grid[neighbor_pos]
            end
        end

        neighbors_arr
    end

    def neighbor_bombs_count
        bomb_count = 0
        neighbors.each do |tile| 
            bomb_count += 1 if tile.bombed
        end
        return bomb_count
    end
end