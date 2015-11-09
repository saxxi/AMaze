class AStar < Solver

  # G cost = distance from starting point
  # H cost = distance from node
  # F = G + H

  def solve!
    @found = false
    @points = Array.new(@grid.length * 2 + 1) { Array.new(@grid.first.length * 2 + 1) }
    @positions = {}
    search @start_x, @start_y
    @grid[@start_y][@start_x] = ELEMENTS[:start]
    @grid[@end_y][@end_x] = ELEMENTS[:end]
  end

  def search(x, y)
  # 40.times do
    @grid[y][x] = ELEMENTS[:fully_explored]
    @positions.delete [x, y]
    return if finished? x, y

    DIRECTIONS.each do |direction|
      tx = x + STEP_X[direction]
      ty = y + STEP_Y[direction]

      @points[ty][tx] ||= { g: distance_from(tx, ty) }
      if @grid[ty][tx] == 0 && !@points[ty][tx][:e]
        @points[ty][tx][:e] = true # fully explored
        heuristic = STEP_X[direction].abs + STEP_Y[direction].abs > 0 ? 1 : 0
        @grid[ty][tx] = ELEMENTS[:unexplored]
        @positions[[tx, ty]] = @points[ty][tx][:g] + heuristic
      end
    end

    position = @positions.to_a.sort{ |a, b| a[1] <=> b[1] }.first[0]
    search position[0], position[1]
    # x, y = position[0], position[1]
  # end
  end

  private

  def distance_from(x, y)
    Math.sqrt((@end_y - y)**2 + (@end_x - x)**2)
  end

  def finished?(x, y)
    distance_from(x, y) == 0
  end

end
