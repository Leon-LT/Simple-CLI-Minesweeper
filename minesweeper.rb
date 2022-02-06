require_relative "grid"
require_relative "tile"
require "yaml"

class Minesweeper
    attr_reader :grid
    def initialize(grid_size = 9)
        @grid = Grid.new(grid_size)
        @lost = false
    end

    def self.load_game
        game = YAML::unsafe_load_file(File.expand_path("./save_files/save.yml"))
        game.play
    end

    def save_game
        File.write(File.expand_path("./save_files/save.yml"), "")
        yaml = YAML.dump(self)
        File.write(File.expand_path("./save_files/save.yml"), "#{yaml}")
    end 

    def win?
        @grid.all_revealed?
    end

    def valid_coords?(coords)
        if coords.length != 2
            return false
        end

        coords.all? { |coord| coord.to_i < @grid.grid_size}  
    end

    def coords_input
        coords =  ""
        until valid_coords?(coords)
            puts "Enter coordinates (eg. 5,4)"
            print "> "
            coords = gets.chomp.split(",")
        end
       coords.map(&:to_i)
    end

    def toggle_input(coords)
        p_input = ""
        until p_input == "F" || p_input == "R"
            puts "Enter 'F' to flag a tile or 'R' to reveal a tile or enter S to save."
            print "> "
            p_input = gets.chomp.upcase 
            case p_input
            when "F" 
                @grid[coords].toggle_flag
            when "R" 
                @lost = true if @grid[coords].bombed
                @grid[coords].reveal
            when "S"
                save_game
                puts "Game saved! You can now close the game pressing Ctrl + C."
            end
        end
    end

    def play
        until win? || @lost
            system("clear")
            @grid.render
            toggle_input(coords_input)
        end
        @grid.cheat
        if win?
            puts "Good job!"
        else
            puts "Nice try"
        end
    end
end

choice = nil
until choice == "load" || choice == "new" 
    puts "Do you want to play a new game or load a save\n Type load or new"
    print "> "
    choice = gets.chomp
end

if choice == "load"
    Minesweeper.load_game
else
    puts "Enter grid size"
    print "> "
    game = Minesweeper.new(gets.chomp.to_i)
    game.play
end

