class Displayer

  include Constants

  def self.debug(grid)
    require 'colorize'
    puts
    grid.length.times do |y|
      grid[y].length.times do |x|
        line = case grid[y][x]
        when ELEMENTS[:wall]
          ' '.on_red
        when ELEMENTS[:unexplored]
          ' '.on_blue
        when ELEMENTS[:fully_explored]
          ' '.on_yellow
        when ELEMENTS[:start]
          ' '.on_green
        when ELEMENTS[:end]
          ' '.on_cyan
        else
          ' '
        end
        print line
      end
      puts
    end
  end

end
