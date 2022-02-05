require_relative "tile"

class Grid
    attr_reader :grid_size, :grid
    def initialize(grid_size )
        @grid = Array.new(grid_size) { Array.new(grid_size)}
        @grid_size = grid_size
        fill_grid
        place_bombs
    end

    def [](pos)
        x, y = pos
        @grid[x][y]
    end

    def []=(pos, value)
        x,y = pos
        @grid[x][y] = value
    end

    def fill_grid
        @grid = @grid.each_with_index do |row,x|
            row.each_with_index do |tile,y|
                pos = [x,y]
                @grid[x][y] = Tile.new([x,y], self)   
            end
        end
    end

    def place_bombs
        bombs_quantity = 9
        bombs_in_the_grid = 0
        until bombs_in_the_grid == bombs_quantity
            rand_x, rand_y = rand(0...@grid_size), rand(0...@grid_size)
            if !@grid[rand_x][rand_y].bombed
                @grid[rand_x][rand_y].is_bomb
                bombs_in_the_grid += 1
            end
        end
    end

    def render
        @grid.each do |row| 
            arr = []
            row.each do |tile|
               if tile.neighbor_bombs_count > 0 && tile.revealed
                    arr << tile.neighbor_bombs_count
               elsif tile.flagged
                   arr << "F"
               elsif tile.revealed
                    arr << "_"
               else
                   arr << "#"
               end
            end
            puts arr.join(" ")
        end 
        true
    end

    def cheat
           @grid.each do |row| 
            arr = []
            row.each do |tile|
               if tile.flagged
                   arr << "F"
               elsif tile.revealed
                    arr << "_"
               elsif tile.bombed
                    arr << "B"
               else
                   arr << "#"
               end
            end
            puts arr.join(" ")
        end 
        true
    end

    def all_revealed?
        @grid.each do |row|
            return false if !row.none? { |tile| !tile.revealed && !tile.bombed}
        end
        true
    end
end