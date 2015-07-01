require 'spec_helper'
require 'battleship/board'

describe Board do
  before(:each) do
    subject { Board.new }
  end

  context "Initial state of the board" do
    it "has size 9" do
      expect(subject.size).to eq(9)
    end
    it "has no ships" do
      expect(subject.ships).to be_empty
    end
    it "has no shots" do
      expect(subject.shots).to be_empty
    end
  end

  context "Placing ships on the board" do
    it "can't place the ship when it's outside the board" do
      ship = double("ship", coords: [[0, 13], [1, 0]])
      expect(subject.can_place_ship? ship).to be_falsey
      subject.place_ship ship
      expect(subject.ships).to be_empty
    end

    context "When the ship is inside the board"
    before(:each) do
      @ship = double(coords: [[0, 0], [1, 0]])
    end

    it "can place a ship when it's not over other ship" do
      expect(subject.can_place_ship? @ship).to be_truthy
      subject.place_ship @ship
      expect(subject.ships).to eq([@ship])
    end

    it "can't place a ship when it's over other ship" do
      second_ship = double(coords: [[0, 0], [0, 9]])

      expect(subject.can_place_ship? @ship).to be_truthy
      subject.place_ship @ship
      expect(subject.can_place_ship? second_ship).to be_falsey
      subject.place_ship second_ship
      expect(subject.ships).to eq([@ship])
    end
  end

  context "#inside_board?" do
    it "is inside if both coords are bigger than 0 and smaller than size" do
      expect(subject.inside_board?([0, 0])).to be_truthy
      expect(subject.inside_board?([3, 5])).to be_truthy
      expect(subject.inside_board?([6, 6])).to be_truthy
      expect(subject.inside_board?([0, 9])).to be_truthy
      expect(subject.inside_board?([9, 0])).to be_truthy
      expect(subject.inside_board?([9, 9])).to be_truthy
    end

    it "is not inside if at least one coord is smaller than 0 bigger or than size" do
      expect(subject.inside_board?([-1, -1])).to be_falsey
      expect(subject.inside_board?([-1, 0])).to be_falsey
      expect(subject.inside_board?([0, -1])).to be_falsey
      expect(subject.inside_board?([10, 0])).to be_falsey
      expect(subject.inside_board?([0, 10])).to be_falsey
      expect(subject.inside_board?([10, 10])).to be_falsey
    end
  end
end
