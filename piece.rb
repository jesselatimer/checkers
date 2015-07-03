class Piece

  RED_STEPS   = [[ 1, 1], [ 1, -1]]
  BLACK_STEPS = [[-1, 1], [-1, -1]]
  RED_JUMPS   = [[ 2, 2], [ 2, -2]]
  BLACK_JUMPS = [[-2, 2], [-2, -2]]

  attr_reader :valid_moves, :valid_steps, :valid_jumps, :to_capture, :current_position, :color, :board

  def initialize(color, current_position, board)
    @current_position = current_position
    @color = color
    @board = board
    @king = false
  end

  def generate_moves
    @valid_steps = []
    @valid_jumps = []
    @to_capture = []
    move_type = king? ? :both : color
    case move_type
    when :red
      generate_steps(RED_STEPS)
      generate_jumps(RED_JUMPS, RED_STEPS)
    when :black
      generate_steps(BLACK_STEPS)
      generate_jumps(BLACK_JUMPS, BLACK_STEPS)
    when :both
      generate_steps(RED_STEPS)
      generate_jumps(RED_JUMPS, RED_STEPS)
      generate_steps(BLACK_STEPS)
      generate_jumps(BLACK_JUMPS, BLACK_STEPS)
    end
    @valid_moves = @valid_steps + @valid_jumps
  end

  def perform_moves(move_queue)
    move_queue.each do |moves|
      start_pos, move_pos = moves
      unless move_pos == start_pos
        if jump?(start_pos, move_pos)
          i = valid_jumps.index(move_pos)
          board[to_capture[i]] = EmptyTile.new
        end
        @king = true if move_pos[0] == 0 || move_pos[0] == 7
        @board[move_pos] = self
        @board[@current_position] = EmptyTile.new
        @current_position = move_pos
      end
    end
  end

  def jump?(start_pos, move_pos)
    # Better way to do this?
    (start_pos[0].abs - move_pos[0].abs).abs > 1
  end

  def generate_steps(positions)
    positions.each do |pos|
      target_pos = (Vector[*pos] + Vector[*current_position]).to_a
      if empty_tile?(target_pos)
        @valid_steps << target_pos
      end
    end
  end

  def generate_jumps(positions, jumped_positions)
    positions.each_with_index do |pos, i|
      target_pos = (Vector[*pos] + Vector[*current_position]).to_a
      jumped_pos = (Vector[*jumped_positions[i]] + Vector[*current_position]).to_a
      if empty_tile?(target_pos) && enemy?(jumped_pos)
        @valid_jumps << target_pos
        @to_capture << jumped_pos
      end
    end
  end

  def enemy?(pos)
    enemy_color = (color == :red ? :black : :red)
    @board[pos].color == enemy_color
  end

  def empty_tile?(pos)
    @board.on_board?(pos) && @board[pos].is_empty?
  end

  def is_empty?
    false
  end

  def inspect
    if king?
      return " ⚛ ".colorize(:color => :red) if color == :red
      return " ⚛ ".colorize(:color => :black) if color == :black
    else
      return " ⚙ ".colorize(:color => :red) if color == :red
      return " ⚙ ".colorize(:color => :black) if color == :black
    end
    " ? "
  end

  def to_s
    inspect
  end

  def king?
    @king
  end

  def valid_move?(pos)
    valid_moves.include?(pos)
  end

  def color?(other_color)
    color == other_color
  end
end

class EmptyTile

  attr_reader :valid_moves, :valid_steps, :valid_jumps, :color

  def initialize(color = :none)
    @valid_steps = []
    @valid_jumps = []
    @valid_moves = []
    @color = color
  end

  def inspect
    "   "
  end

  def valid_move?(pos)
    false
  end

  def is_empty?
    true
  end

  def to_s
    inspect
  end

  def king?
    false
  end

  def color?(other_color)
    color == other_color
  end

end
