require_relative 'piece'
require_relative 'modules/populateable'

class Board
  include Populateable

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptyTile.new } }
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

  def on_board?(pos)
    pos.all? { |num| num.between?(0, 7) }
  end

  private

  # other methods

end
