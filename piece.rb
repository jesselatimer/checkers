class Piece

  def initialize(color)
    @color = color
    @king = false
  end

  def king?
    @king
  end

  private
  attr_reader :color

end

class EmptyTile
  def initialize(color = :none)
    @color = color
  end

  def king?
    false
  end

  private
  attr_reader :color

end
