class Piece

  RED_STEPS   = [[ 1, 1], [ 1, -1]]
  BLACK_STEPS = [[-1, 1], [-1, -1]]
  RED_JUMPS   = [[ 2, 2], [ 2, -2]]
  BLACK_JUMPS = [[-2, 2], [-2, -2]]

  attr_reader :valid_moves, :valid_steps, :valid_jumps, :current_position, :color

  def initialize(color, current_position, board)
    @current_position = current_position
    @color = color
    @board = board
    @king = false
  end

  def generate_moves
    @valid_steps = []
    @valid_jumps = []
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
      if empty_tile?(target_pos) && enemy?(jumped_positions[i])
        @valid_steps << target_pos
      end
    end
  end

  def enemy?(pos)
    enemy_color = color == :red ? :black : :red
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
end

class EmptyTile

  attr_reader :valid_moves

  def initialize(color = :none)
    @valid_moves = []
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
