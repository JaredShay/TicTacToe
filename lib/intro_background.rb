require_relative './color'

class IntroBackground
  include Color

  attr_reader :buffer
  def initialize(width, height)
    @buffer = []
    @width  = width
    @height = height

    paint
  end

  def tick(state)
  end

  def render?
    false # static, doesn't need re-rendering
  end

  def paint
    @height.times do |row|
      @width.times do |col|
        @buffer << [row, col, color(' ', :white, :white)]
      end
    end
  end
end
