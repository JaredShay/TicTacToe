require_relative './element'

class GameBorder
  include Element
  extend Element

  TURN_O_TRANSITION = [
    [300, color('·', :black, :white)],
    [200,  color('o', :black, :white)],
    [100, color('O', :black, :white)],
  ]

  TURN_O_HOLD = [
    [1000, color('O', :black, :white)],
    [500,  color('o', :black, :white)],
  ]

  def initialize(width, height)
    @width  = width
    @height = height

    @animations = AnimationSequence.new(
      [
        Animation.new(TURN_O_TRANSITION),
        Animation.new(TURN_O_HOLD, infinite: true),
      ]
    )

    paint
    @render = true
  end

  def tick(game_state)
    @animations.tick(game_state.time_in_ms)

    if @animations.transitioned?
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
    tile = @animations.tile

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
