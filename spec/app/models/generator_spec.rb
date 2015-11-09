require "rails_helper"

describe Generator do

  subject { Generator }

  it "able to return the grid" do
    width, height = 20, 10
    maze = subject.new(width, height)

    expect(maze.grid.length).to eq height * 2 + 1
    expect(maze.grid[0].length).to eq width * 2 + 1
  end

end
