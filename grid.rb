require_relative "tile"

class Grid
    attr_reader :grid
    def initialize(grid_size = 9)
        @grid = Array.new(grid_size) { Array.new(grid_size)}
        @grid_size = grid_size
    end

    def fill_grid
        @grid = @grid.each_with_index do |row,x|
            row.each_with_index do |tile,y|
                pos = [x,y]
                tile = nil   
            end
        end
    end


end