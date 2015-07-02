require_relative 'piece'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) EmptyTile.new }
  end

  def populate
    # populate starting positions
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
  attr_reader :grid

  # other methods

end
