require 'io/console'
require 'colorize'

class Display

  def initialize(board)
    @board = board
  end

  def render
    system("clear")
    print_board
    puts "This is further instruction in the game."
  end

  def print_board
    board.grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if (i + j) % 2 == 0
          print tile.to_s.colorize(:background => :white)
        elsif (i + j) % 2 > 0
          print tile.to_s.colorize(:background => :light_white)
        end
      end
      puts
    end
  end

  def cursor_move?(input)
    # true if one of the cursor movement keys
  end

  def move_cursor(input)
    # maps to hash of directions to move the cursor from its current pos
  end

  private
  attr_reader :board

end
