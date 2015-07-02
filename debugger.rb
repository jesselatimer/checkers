class Debugger

  def initialize(board)
    @board = board
  end

  def display(selection_cursor)
    puts "### DEBUGGER ###"
    puts  "CLASS: #{@board[selection_cursor].class}"
    puts "Movement mode? #{@board.movement_mode}"
  end

end
