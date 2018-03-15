require_relative './color'
require_relative './game_state'

class IntroBorder
  include Color

  attr_reader :buffer
  def initialize(width, height)
    @width  = width
    @height = height

    paint
  end

  def tick(game_state)
  end

  def render?
    false
  end

  def paint
    tile = color(' ', :blue, :blue)

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
