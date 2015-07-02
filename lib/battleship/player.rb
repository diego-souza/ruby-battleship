require 'battleship/board'

class Player
  attr_reader :id, :board

  def initialize id, board
    @id = id
    @board = board
  end

  def dead?
    @board.ships.delete_if { |ship| @board.sunken_ships.include? ship }.empty?
  end
end
