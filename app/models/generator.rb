class Generator

  include Constants

  attr_accessor :grid

  def initialize(width, height = nil)
    @width  = width
    @height = height || width
    generate!
  end

  def generate!
    @grid = Array.new(@height * 2 + 1) { Array.new(@width * 2 + 1, 1) }
    carve_from 1,1
  end

  private

  def carve_from(x, y)
    DIRECTIONS.shuffle.each do |direction|
      px = x + STEP_X[direction] * 2
      py = y + STEP_Y[direction] * 2

      if px.between?(1, @width * 2) &&
         py.between?(1, @height * 2) &&
         @grid[py] && @grid[py][px] == 1

        ox = px + STEP_X[INVERT[direction]]
        oy = py + STEP_Y[INVERT[direction]]
        @grid[py][px] = 0
        @grid[oy][ox] = 0

        carve_from px, py
      end
    end
  end

end
