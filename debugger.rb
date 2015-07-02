class Debugger

  def initialize(board)
    @board = board
  end

  def display(selection_cursor)
    puts "### DEBUGGER ###"
    p "CLASS: #{@board[selection_cursor].class}"
  end

end
