class Debugger

  def initialize(board, display)
    @board = board
    @display = display
  end

  def display(selection_cursor)
    puts "### DEBUGGER ###"
    puts "Current Player: #{@display.current_player.color}"
    puts "CLASS: #{@board[selection_cursor].class}"
    puts "Valid moves: #{@board[selection_cursor].valid_moves}"
    puts "Valid steps: #{@board[selection_cursor].valid_steps}"
    puts "Valid jumps: #{@board[selection_cursor].valid_jumps}"
    puts "Move queue: #{@board.move_queue}"
    puts "Movement mode? #{@board.movement_mode}"
    puts ""
  end

end
