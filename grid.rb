require_relative "tile"

class Grid
    attr_reader :grid
    def initialize(grid_size = 9)
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
            if !@grid[rand_x][rand_y].is_a? Tile
                @grid[rand_x][rand_y].is_bomb
                bombs_in_the_grid += 1
            end
        end
    end

    def render
        @grid.each do |row| 
            arr = []
            row.each do |tile|
                arr << tile
            end
            puts arr.join(" ")
        end 
    end

end