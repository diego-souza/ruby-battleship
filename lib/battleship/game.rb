require 'battleship/player'

class Game
  attr_reader :player1, :player2, :current_player

  def initialize params = {}
    @player1 = params[:player1] || Player.new(:player1)
    @player2 = params[:player2] || Player.new(:player2)
    @current_player = @player1
  end

  def end_turn
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def game_over?
    @player1.dead? || @player2.dead?
  end

  def winner
    if @player1.dead?
      @player2
    elsif @player2.dead?
      @player1
    else
      nil
    end
  end

end
