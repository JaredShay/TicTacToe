require_relative './element'

class Game
  include Element
  extend Element

  def initialize(width, height)
    @tiles = [
      color('-', :default, :default),
      color('.', :default, :default)
    ].cycle
    @tile = @tiles.next

    @width  = width
    @height = height

    @time_of_state_change_ms = 0

    paint
    @render = true
  end

  def tick(state)
    if state.key_pressed
      @tile = @tiles.next

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
    @buffer = []
    @height.times do |row|
      @width.times do |col|
        @buffer << [row, col, @tile]
      end
    end
  end
end
