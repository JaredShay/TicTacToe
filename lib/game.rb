require_relative './element'

class Game
  include Element
  extend Element

  def initialize(width, height)
    @tiles = [
      color('-', :default, :default)
    ].cycle

    @width  = width
    @height = height

    @time_of_state_change_ms = 0

    paint
    @render   = true
  end

  def tick(state)
    if state.time_in_ms - @time_of_state_change_ms >= 2000
      @time_of_state_change_ms = state.time_in_ms

      paint
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
