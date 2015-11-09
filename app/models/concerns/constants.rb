module Constants

  DIRECTIONS = %I(N S E W)
  STEP_X   = { E: 1, W: -1, N:  0, S: 0 }
  STEP_Y   = { E: 0, W:  0, N: -1, S: 1 }
  INVERT = { E: :W, W: :E, N: :S, S: :N }

  ELEMENTS = {
    :empty => 0,
    :wall => 1,
    :unexplored => 2,
    :fully_explored => 3,
    :start => 4,
    :end => 5,
  }

end
