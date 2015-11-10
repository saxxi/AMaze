class Solver

  include Constants

  attr_accessor :grid

  def initialize(grid, opts = {})
    @width, @height = grid.first.length - 1, grid.length - 1
    @grid = grid

    if opts.values.join('').present?
      @start_x, @start_y = opts[:start_x].to_i, opts[:start_y].to_i
      @end_x, @end_y = opts[:end_x].to_i, opts[:end_y].to_i
      raise 'Invalid game parameters!' unless valid_params?
    else
      begin
        @start_x = rand(@width) + 1
        @start_y = rand(@height) + 1
        @end_x = rand(@width) + 1
        @end_y = rand(@height) + 1
      end while ! valid_params?
    end
  end

  def solve!
    raise 'Extend this class!'
  end

  private

  def valid_params?
    @grid[@start_y][@start_x] == 0 && @grid[@end_y][@end_x] == 0
  end

end
