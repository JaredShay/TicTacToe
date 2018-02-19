require_relative './element'

class GameBorder
  include Element
  extend Element

  STATES = [
    [150, color('·', :white, :default)],
    [200,  color('o', :white, :default)],
    [1000, color('O', :white, :default)],
    [1000, color('X', :white, :default)],
    [1000, color('O', :white, :default)],
    [200,  color('o', :white, :default)],
    [150, color('·', :white, :default)],
  ]

  def initialize(width, height)
    @width  = width
    @height = height

    @states                  = STATES.cycle
    @time_of_state_change_ms = 0
    @state                   = @states.next

    paint
    @render = true
  end

  def tick(game_state)
    if (game_state.time_in_ms - @time_of_state_change_ms) >= @state[0]
      @state = @states.next
      @time_of_state_change_ms = game_state.time_in_ms

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
    tile = @state[1]

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
