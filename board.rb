require_relative 'piece'

class Board

  COMMANDS = {
    "\r" => :enter,
    "."  => :confirm,
    'q'  => :quit,
  }

  attr_accessor :grid, :movement_mode, :move_queue

  def initialize
    @grid = Array.new(8) { Array.new(8) { } }
    populate
    @movement_mode = false
    @move_queue = []
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

  def execute_command(input, display)
    command = COMMANDS[input]
    if command == :quit
      abort
    elsif command == :populate
        populate
    elsif command == :enter
      if movement_mode && valid_move?(display)
        # Once multiple jumping is enabled, this should shovel.
        @move_queue = [[display.selection_cursor, display.movement_cursor]]
      elsif display.current_player.color == self[display.selection_cursor].color
        display.set_selection_cursor
        toggle_movement_mode
        @move_queue = []
      end
    elsif command == :confirm
      if move_queue.length > 0
        piece = self[display.selection_cursor]
        piece.perform_moves(move_queue)
        display.set_selection_cursor
        toggle_movement_mode
        @move_queue = []
        return true
      else
        puts "No moves selected."
      end
    end
    false
    #   else
    #     raise "Execute_command error"
    #   end
    # end
  end

  def in_queue?(pos)
    @move_queue.any? { |moves| moves[1] == pos }
  end

  def valid_move?(display)
    self[display.selection_cursor].valid_move?(display.movement_cursor)
  end

  def generate_moves
    grid.each do |row|
      row.each do |tile|
        unless tile.is_empty?
          tile.generate_moves
        end
      end
    end
  end

  def toggle_movement_mode
    @movement_mode = !movement_mode
  end

  def on_board?(pos)
    pos.all? { |num| num.between?(0, 7) }
  end

  def over?(player)
    grid.all? { |row| row.none? { |tile| tile.color == player.color } }
  end

  # def populate
  #   @grid = grid.map.with_index do |row, i|
  #     row.map.with_index do |tile, j|
  #       if (i + j) % 2 == 0 && i < 3
  #         Piece.new(:red, [i, j], self)
  #       elsif (i + j) % 2 == 0 && i > 4
  #         Piece.new(:black, [i, j], self)
  #       else
  #         EmptyTile.new
  #       end
  #     end
  #   end
  # end

  def populate
    @grid = grid.map do |row|
      row.map { |tile| EmptyTile.new }
    end
    self[[2,2]] = Piece.new(:red, [2, 2], self)
    self[[3,3]] = Piece.new(:black, [3, 3], self)
  end

end
