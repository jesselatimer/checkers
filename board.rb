require_relative 'piece'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptyTile.new } }
  end

  def populate
    # populate starting positions

    # TEMP
    # @grid = grid.map do |el|
    #   x = rand(8)
    #   if x % 2 == 0
    #     Piece.new(:black)
    #   else
    #     Piece.new(:red)
    #   end
    # end
    # grid
  end

  def command?(input)
    # returns true if the input is in the commands hash
  end

  def execute_command(input)
    # if "enter"
    #   if display.confirmation_mode?
    #     perform moves
    #   if display.move_mode?
    #     add move to queue
    #   if selection mode
    #     select piece
    #   else
    #     raise "Execute_command error"
    #   end
    # end
  end

  private

  # other methods

end
