require 'matrix'

require_relative 'player'
require_relative 'board'
require_relative 'display'

# Still to-do: multi-jumping and forced jumping.

class Game

  def initialize
    @players = [Player.new(:red), Player.new(:black)]
    @board = Board.new
    @display = Display.new(board)
  end

  def play
    board.execute_command(:populate, display)
    until over?
      board.generate_moves
      @current_player = players.first
      display.render(current_player)
      begin
        input = current_player.play_turn
        if display.cursor_move?(input)
          display.move_cursor(input)
        elsif board.command?(input)
          players.reverse! if board.execute_command(input, display)
        else
          raise InvalidCommandError
        end
      rescue InvalidCommandError => e
        puts "#{e.message}"
        retry
      end
    end
    display.render(current_player)
    puts "#{players.last.color.to_s.upcase} WON"
  end

  private
  attr_reader :players, :current_player, :display, :board

  def over?
    board.over?(players.first)
  end

end

class InvalidCommandError < StandardError
end

game = Game.new
game.play
