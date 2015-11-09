class GamesController < ApplicationController

  def index
  end

  def create
    grid = Generator.new(
      maze_params[:width].to_i,
      maze_params[:height].to_i
    ).grid

    solver = AStar.new(grid, game_params)
    solver.solve!

    render json: { grid: grid }
  end

  private

  def maze_params
    params.require(:maze).permit :width, :height
  end

  def game_params
    params.require(:game).permit :start_x, :start_y, :end_x, :end_y
  end

end
