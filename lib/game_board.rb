require_relative './color'

class GameBoard
  include Color

  attr_reader :buffer
  def initialize(width, height)
    @width  = width
    @height = height

    paint
  end

  def tick(state)
  end

  def render?
    false
  end

  def paint
    tile = color(' ', :white, :white)

    @buffer = []
    (@height).round.times do |row|
      (@width).round.times do |col|
        @buffer << [row, col, tile]
      end
    end
  end
end
