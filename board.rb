require_relative 'piece'

class Board

  COMMANDS = {
    "\r" => :enter,
    'q'  => :quit
  }

  attr_accessor :grid, :movement_mode

  def initialize
    @grid = Array.new(8) { Array.new(8) { } }
    populate
    @movement_mode = false
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def command?(input)
    COMMANDS.keys.include?(input)
  end

  def execute_command(input)
    command = COMMANDS[input]
    if command == :quit
      abort
    elsif command == :enter
      # if movement_mode
      toggle_movement_mode
      # end
    end

    #   if display.confirmation_mode?
    #     perform moves
    #   if display.move_mode?
    #     add move to queue
    #   if selection mode
    #     select piece
    #   else
    #     raise "Execute_command error"
    #   end
    # end
  end

  def toggle_movement_mode
    @movement_mode = !movement_mode
  end

  def on_board?(pos)
    pos.all? { |num| num.between?(0, 7) }
  end

  def populate
    @grid = grid.map.with_index do |row, i|
      row.map.with_index do |tile, j|
        if (i + j) % 2 == 0 && i < 3
          Piece.new(:red)
        elsif (i + j) % 2 == 0 && i > 4
          Piece.new(:black)
        else
          EmptyTile.new
        end
      end
    end
  end

end
