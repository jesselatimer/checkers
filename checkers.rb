require_relative 'player'
require_relative 'board'
require_relative 'display'

require 'byebug'

class Game

  def initialize
    @players = [Player.new(:red), Player.new(:black)]
    @current_player = players.first
    @board = Board.new
    @display = Display.new(board)
  end

  def play
    board.populate
    # set player
    # until won?
      display.render
      begin
        input = current_player.play_turn
        return if input == "q" # move into commands
        if display.cursor_move?(input)
          display.move_cursor(input)
        elsif board.command?(input)
          board.execute_command(input)
        else
          raise "Not a valid command."
        end
      rescue => e
        puts "#{e.message}"
        retry
      end
    #   switch player
    # end
    # winning_method
  end

  private
  attr_reader :players, :current_player, :display, :board

end

game = Game.new
game.play
