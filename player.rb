class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    input = $stdin.getch
  end

end
