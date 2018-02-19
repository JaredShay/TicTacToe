require_relative './element'

class Game
  include Element

  def initialize(width, height)
    @tiles = ['-', '.', '*'].cycle

    @width  = width
    @height = height

    paint
    @render   = true

    @time_in_ms              = 0
    @time_of_state_change_ms = 0
  end

  def tick(state)
    if state.time_in_ms - @time_of_state_change_ms >= 2000
      paint
      @time_of_state_change_ms = state.time_in_ms

      @render = true
    else
      @render = false
    end
  end

  def render?
    @render
  end

  def paint
    tile = @tiles.next

    @buffer = []
    @height.times do |row|
      @width.times do |col|
        @buffer << [row, col, tile]
      end
    end
  end
end
