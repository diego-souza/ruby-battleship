class Board
  attr_reader :size, :ships, :shots
  def initialize params = {}
    @size = 9
    @ships = params[:ships] || []
    @shots = params[:shots] || []
  end

  def inside_board? coord
    coord.each do |x|
      if (x < 0) || (x > @size)
        return false
      end
    end
    true
  end

  def place_ship ship
    if can_place_ship? ship
      @ships << ship
    end
  end

  def can_place_ship? ship
    ships_coords = @ships.map(&:coords).flatten(1)
    ship.coords.each do |coord|
      if !inside_board?(coord) || ships_coords.include?(coord)
        return false
      end
    end
    true
  end

  def sunken_ships
    @ships.select {|ship| ship.sunk?}
  end
end
