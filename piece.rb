class Piece

  def initialize(color)
    @color = color
    @king = false
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
