require 'spec_helper'
require 'battleship/ship'

describe Ship do
  before(:each) do
    @subject = Ship.new([1, 1], 2, :north)
  end

  context "Initial state of the ship" do
    it "has a position" do
      expect(@subject.pos).to eq([1, 1])
    end

    it "has a length" do
      expect(@subject.length).to eq(2)
    end

    it "has a direction" do
      expect(@subject.direction).to eq(:north)
    end
  end

  context "#sunk?" do
    it "is not sunk if there are no shots" do
      expect(@subject.sunk? []).to be_falsey
    end

    it "is not sunk if there is at least one part of the ship not shot" do
      expect(@subject.sunk? [[1, 1]]).to be_falsey
    end

    it "is sunk if all parts of the ship are shot" do
      expect(@subject.sunk? [[1, 0], [1, 1]]).to be_truthy
    end
  end

  context "#over?" do
    it "is over if there is at least one part of the ship is equal" do
      expect(@subject.over? [[1, 1]]).to be_truthy
    end

    it "is not over sunk if all parts of the ship are different" do
      expect(@subject.over? [[2, 1], [2, 2]]).to be_falsey
    end
  end

  context "#coords" do
    context "when length is bigger than 1" do
      it "it should subtract from the second coord when direction is north" do
        @subject = Ship.new([1, 1], 2, :north)
        puts "CORDS: #{@subject.coords}"
        expect(@subject.coords).to include([1, 1], [1, 0])
      end

      it "it should add to the second coord when direction is south" do
        @subject = Ship.new([1, 1], 2, :south)
        expect(@subject.coords).to include([1, 1], [1, 2])
      end

      it "it should subtract from the first coord when direction is west" do
        @subject = Ship.new([1, 1], 2, :west)
        expect(@subject.coords).to include([1, 1], [0, 1])
      end

      it "it should add to the first coord when direction is east" do
        @subject = Ship.new([1, 1], 2, :east)
        expect(@subject.coords).to include([1, 1], [2, 1])
      end
    end

    it "should return as many coords as it's length" do
      @subject = Ship.new([1, 1], 4, :south)
      expect(@subject.coords).to include([1, 1], [1, 2], [1, 3], [1, 4])
    end
  end

  context "#delta" do
    it "should return the delta for specified direction" do
      north = Ship.new [1,1], 2, :north
      south = Ship.new [1,1], 2, :south
      east = Ship.new [1,1], 2, :east
      west = Ship.new [1,1], 2, :west

      expect(north.delta).to eq([0, -1])
      expect(south.delta).to eq([0, 1])
      expect(east.delta).to eq([1, 0])
      expect(west.delta).to eq([-1, 0])
    end
  end
end

