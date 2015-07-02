require 'io/console'
require 'colorize'
require_relative 'debugger'

class Display

  DIRECTIONS = {
    ',' => [-1,  0],
    'o' => [ 1,  0],
    'a' => [ 0, -1],
    'e' => [ 0,  1]
  }

  def initialize(board)
    @board = board
    @selection_cursor = [0,0]
    @movement_cursor  = [0,0]
    @movement_mode = false
    @debugger = Debugger.new(board)
    @debug_mode = true
  end

  def render
    system("clear")
    print_board
    puts "This is further instruction in the game."
  end

  def print_board
    board.grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if    [i, j] == movement_cursor && movement_mode
          print tile.to_s.colorize(:background => :light_magenta)
        elsif [i, j] == selection_cursor
          print tile.to_s.colorize(:background => :light_cyan)
        elsif (i + j) % 2 == 0
          print tile.to_s.colorize(:background => :white)
        elsif (i + j) % 2 > 0
          print tile.to_s.colorize(:background => :light_white)
        end
      end
      puts
    end
  end

  def cursor_move?(input)
    DIRECTIONS.keys.include?(input)
  end

  def move_cursor(input)
    cursor_as_vector = (Vector[*DIRECTIONS[input]] + Vector[*@selection_cursor])
    temp_cursor = cursor_as_vector.to_a
    @selection_cursor = temp_cursor if board.on_board?(temp_cursor)
  end

  private
  attr_reader :board, :selection_cursor, :movement_cursor, :movement_mode

end
