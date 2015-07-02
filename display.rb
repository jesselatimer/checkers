require 'io/console'

class Display

  def initialize(board)
    @board = board
  end

  def render
  end

  def cursor_move?(input)
    # true if one of the cursor movement keys
  end

  def move_cursor(input)
    # maps to hash of directions to move the cursor from its current pos
  end

end
