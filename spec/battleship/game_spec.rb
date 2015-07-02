require 'spec_helper'
require 'battleship/game'

describe Game do
  before(:each) do
    subject { Game.new }
  end

  context "Initial state of the game" do
    it "has player 1" do
      expect(subject.player1).not_to be nil
    end

    it "has player 2" do
      expect(subject.player2).not_to be nil
    end

    it "has current player" do
      expect(subject.current_player).to eq(subject.player1)
    end

    it "accpects player 1 as optional parameter" do
      player = double
      subject = Game.new({player1: player})

      expect(subject.player1).to eq(player)
    end

    it "accpects player 2 as optional parameter" do
      player = double
      subject = Game.new({player2: player})

      expect(subject.player2).to eq(player)
    end
  end

  context "#end_turn" do
    it "changes to next player" do
      expect(subject.current_player).to eq(subject.player1)
      subject.end_turn
      expect(subject.current_player).to eq(subject.player2)
      subject.end_turn
      expect(subject.current_player).to eq(subject.player1)
    end
  end

  context "#game_over?" do
    it "is true when one player is dead" do
      player = double(dead?: true)
      subject = Game.new({player1: player})

      expect(subject.game_over?).to be_truthy
    end

    it "is false when both players are alive" do
      player1 = double(dead?: false)
      player2 = double(dead?: false)
      subject = Game.new({player1: player1, player2: player2})

      expect(subject.game_over?).to be_falsey
    end
  end

  context "#winner?" do
    it "has no winner when both players are alive" do
      player1 = double(dead?: false)
      player2 = double(dead?: false)
      subject = Game.new({player1: player1, player2: player2})

      expect(subject.winner).to be nil
    end

    it "is player 1 when player 2 is dead" do
      player1 = double(dead?: false)
      player2 = double(dead?: true)
      subject = Game.new({player1: player1, player2: player2})

      expect(subject.winner).to eq(player1)
    end

    it "is player 2 when player 1 is dead" do
      player1 = double(dead?: true)
      player2 = double(dead?: false)
      subject = Game.new({player1: player1, player2: player2})

      expect(subject.winner).to eq(player2)
    end
  end
end
