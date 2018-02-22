require_relative './color'

class GameBorder
  extend Color

  TURN_1_TRANSITION = [
    [300, color('·', :black, :white)],
    [200,  color('o', :black, :white)],
    [100, color('O', :black, :white)],
  ]

  TURN_1_HOLD = [
    [1000, color('O', :black, :white)],
    [500,  color('o', :black, :white)],
  ]

  TURN_2_TRANSITION = [
    [300, color('·', :black, :white)],
    [200,  color('x', :black, :white)],
    [100, color('X', :black, :white)],
  ]

  TURN_2_HOLD = [
    [1000, color('X', :black, :white)],
    [500,  color('x', :black, :white)],
  ]

  attr_reader :buffer
  def initialize(width, height)
    @width  = width
    @height = height

    @animations = Animations.new('.')

    @animations.push(Animation.new(TURN_1_TRANSITION))
    @animations.push(Animation.new(TURN_1_HOLD, infinite: true))

    paint
    @render = true
  end

  def tick(game_state)
    if game_state.key_pressed == :right_arrow
      @animations.push(Animation.new(TURN_2_TRANSITION))
      @animations.push(Animation.new(TURN_2_HOLD, infinite: true))
    end

    if game_state.key_pressed == :left_arrow
      @animations.push(Animation.new(TURN_1_TRANSITION))
      @animations.push(Animation.new(TURN_1_HOLD, infinite: true))
    end

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
