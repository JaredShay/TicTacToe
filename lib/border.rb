require_relative './color'
require_relative './game_state'

class Border
  extend Color

  TURN_1_TRANSITION = [
    [300, color('·', :white, :black, :bold)],
    [200,  color('o', :white, :black, :bold)],
    [100, color('O', :white, :black, :bold)],
  ]

  TURN_1_HOLD = [
    [800, color('O', :white, :black, :bold)],
    [300,  color('o', :white, :black, :bold)],
  ]

  TURN_2_TRANSITION = [
    [300, color('·', :white, :black, :bold)],
    [200,  color('x', :white, :black, :bold)],
    [100, color('X', :white, :black, :bold)],
  ]

  TURN_2_HOLD = [
    [800, color('X', :white, :black, :bold)],
    [300,  color('x', :white, :black, :bold)],
  ]

  attr_reader :buffer
  def initialize(width, height)
    @width  = width
    @height = height

    @animations = Animations.new('.')

    @player_turn = GameState::PLAYER_ONE
    @animations.push(Animation.new(TURN_1_TRANSITION))
    @animations.push(Animation.new(TURN_1_HOLD, infinite: true))

    paint
    @render = true
  end

  def tick(game_state)
    if game_state.player_turn != @player_turn
      if game_state.player_turn == GameState::PLAYER_TWO
        @animations.push(Animation.new(TURN_2_TRANSITION))
        @animations.push(Animation.new(TURN_2_HOLD, infinite: true))
        @player_turn = GameState::PLAYER_TWO
      else
        @animations.push(Animation.new(TURN_1_TRANSITION))
        @animations.push(Animation.new(TURN_1_HOLD, infinite: true))
        @player_turn = GameState::PLAYER_ONE
      end
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
