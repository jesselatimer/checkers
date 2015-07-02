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
    @debugger = Debugger.new(board)
    @debug_mode = true
  end

  def render
    system("clear")
    print_board
    puts "This is further instruction in the game."
    @movement_cursor = @selection_cursor unless board.movement_mode
  end

  def print_board
    board.grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if    [i, j] == movement_cursor && board.movement_mode
          print tile.to_s.colorize(:background => :cyan)
        elsif board[@selection_cursor].valid_move?([i, j]) && board.movement_mode
          print tile.to_s.colorize(:background => :green)
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
    @debugger.display(selection_cursor) if @debug_mode
  end

  def cursor_move?(input)
    DIRECTIONS.keys.include?(input)
  end

  def move_cursor(input)
    if board.movement_mode
      cursor_as_vector = (Vector[*DIRECTIONS[input]] + Vector[*@movement_cursor])
      temp_cursor = cursor_as_vector.to_a
      @movement_cursor = temp_cursor if board.on_board?(temp_cursor)
    else
      cursor_as_vector = (Vector[*DIRECTIONS[input]] + Vector[*@selection_cursor])
      temp_cursor = cursor_as_vector.to_a
      @selection_cursor = temp_cursor if board.on_board?(temp_cursor)
    end
  end

  private
  attr_reader :board, :selection_cursor, :movement_cursor

end
