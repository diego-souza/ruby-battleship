class Ship
  attr_reader :pos, :length, :direction

  def initialize(pos, length, direction)
    @pos = pos
    @length = length
    @direction = direction
  end

  def sunk? shots
    coords.delete_if { |coord| shots.include? coord }.empty?
  end

  def over? other_coords
    other_coords.delete_if { |coord| coords.include? coord }.empty?
  end

  def coords
    coords_array = []
    @length.times do |i|
      x = pos.first + (delta.first * i)
      y = pos.last + (delta.last * i)
      coords_array << [x, y]
    end
    coords_array
  end

  def delta
    case @direction
    when :north
      d = [0, -1]
    when :south
      d = [0, 1]
    when :east
      d = [1, 0]
    when :west
      d = [-1, 0]
    end
    d
  end
end
