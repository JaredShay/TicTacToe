require_relative './element'

class GameBorder
  include Element

  def initialize(width, height)
    @tiles = ['x', 'o'].cycle

    @width  = width
    @height = height

    paint
    @render   = true

    @time_in_ms              = 0
    @time_of_state_change_ms = 0
  end

  def tick(state)
    if state.time_in_ms - @time_of_state_change_ms >= 1000
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

    (0...@width).to_a.each do |col|
      @buffer << [0, col, tile]
      @buffer << [@height - 1, col, tile]
    end

    (0...@height).to_a.each do |row|
      @buffer << [row, 0, tile]
      @buffer << [row, @width - 1, tile]
    end
  end
end
