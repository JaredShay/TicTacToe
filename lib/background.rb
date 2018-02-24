require_relative './color'

class Background
  include Color

  attr_reader :buffer
  def initialize(width, height)
    @tiles = [
      color('-', :light_gray, :light_blue),
      color('.', :light_gray, :light_blue)
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
        if Random.rand(0..10) == 10
          @buffer << [row, col, color('#', :light_gray, :light_cyan)]
        else
          @buffer << [row, col, @tile]
        end
      end
    end
  end
end
