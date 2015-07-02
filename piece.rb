class Piece

  RED_STEPS   = [[ 1, 1], [ 1, -1]]
  BLACK_STEPS = [[-1, 1], [-1, -1]]
  RED_JUMPS   = [[ 2, 2], [ 2, -2]]
  BLACK_JUMPS = [[-2, 2], [-2, -2]]

  def initialize(color, current_position, board)
    @current_position = current_position
    @color = color
    @board = board
    @king = false
  end

  def generate_moves
    @valid_moves = []
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
  end

  def generate_steps(positions)
    positions.each do |pos|
      if empty_tile?(pos)
        @valid_moves << (Vector[*pos] + Vector[*current_position]).to_a
      end
    end
  end

  def generate_jumps(positions, jumped_positions)
    positions.each_with_index do |pos, i|
      if empty_tile?(pos) && !empty_tile?(jumped_positions[i])
        @valid_moves << (Vector[*pos] + Vector[*current_position]).to_a
      end
    end
  end

  def empty_tile?(pos)
    @board.on_board?(pos) && @board[pos].is_empty?
  end

  def is_empty?
    false
  end

  def inspect
    if king?
      return " O ".colorize(:color => :red) if color == :red
      return " O ".colorize(:color => :black) if color == :black
    else
      return " o ".colorize(:color => :red) if color == :red
      return " o ".colorize(:color => :black) if color == :black
    end
    " ? "
  end

  def to_s
    inspect
  end

  def king?
    @king
  end

  def color?(other_color)
    color == other_color
  end

  private
  attr_reader :color

end

class EmptyTile
  def initialize(color = :none)
    @color = color
  end

  def inspect
    "   "
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

  private
  attr_reader :color

end
