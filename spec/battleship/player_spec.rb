require 'spec_helper'
require 'battleship/player'

describe Player do
  before(:each) do
    @subject = Player.new(:player1)
  end

  context "Initial state of the player" do
    it "has an id" do
      expect(@subject.id).to eq(:player1)
    end

    it "has a board" do
      expect(@subject.board).not_to be nil
    end

    it "accepts a board as optional parameter" do
      board = double
      @subject = Player.new :player1, {board: board}
      expect(@subject.board).to eq(board)
    end
  end

  context "#dead?" do
    it "is not dead when at least one ship is not sunk" do
      ship = double
      board = double(sunken_ships: [], ships: [ship])
      alive_player = Player.new :alive, {board: board}

      expect(alive_player.dead?).to be_falsey
    end

    it "is dead when all the ships are sunken" do
      ship = double
      board = double(sunken_ships: [ship], ships: [ship])
      alive_player = Player.new :alive, {board: board}

      expect(alive_player.dead?).to be_truthy
    end
  end

end
