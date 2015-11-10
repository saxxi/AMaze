class AStar < Solver

  # G cost = Manhattan distance from starting point
  # H cost = Distance from node
  # F = G + H

  def solve!
    @found = false
    @points = Array.new(@height * 2 + 1) { Array.new(@width * 2 + 1) }
    @positions = {}
    search @start_x, @start_y
    @grid[@start_y][@start_x] = ELEMENTS[:start]
    @grid[@end_y][@end_x] = ELEMENTS[:end]
  end

  def search(x, y)
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
  end

  private

  def distance_from(x, y)
    walls_hv, walls_vh = 0, 0

    h_start = [@end_x, x].min
    h_end = (@end_x - x).abs + h_start
    (h_start..h_end).each do |elem|
      walls_hv += @grid[y][elem]      == 1 ? 10 : 1
      walls_vh += @grid[@end_y][elem] == 1 ? 10 : 1
    end

    v_start = [@end_y, y].min
    v_end = (@end_y - y).abs + v_start
    (v_start..v_end).each do |elem|
      walls_hv += @grid[elem][@end_x] == 1 ? 10 : 1
      walls_vh += @grid[elem][x]      == 1 ? 10 : 1
    end

    [walls_hv, walls_vh].min
  end

  def finished?(x, y)
    y == @end_y && x == @end_x
  end

end
