require_relative './color'

class GamePresenter
  include Color

  COL_SIZE         = 11
  COL_DIVIDER_SIZE = 2
  ROW_SIZE         = 4
  ROW_DIVIDER_SIZE = 1

  attr_reader :buffer
  def initialize(game)
    @size = game.size

    @row_length = (COL_SIZE * @size) + ((@size - 1) * COL_DIVIDER_SIZE)
    @col_height = (ROW_SIZE * @size) + ((@size - 1) * ROW_DIVIDER_SIZE)

    @row_dividers = []
    (@size - 1).times do |row|
      @row_length.times do |col|
        @row_dividers << [
          ((row + 1) * (ROW_SIZE + ROW_DIVIDER_SIZE) - 1),
          col,
          color('-', :blue, :black)
        ]
      end
    end

    @col_divider = color('/', :blue, :black)
    @col_dividers = []
    @col_height.times do |row|
      (@size - 1).times do |col|
        @col_dividers << [
          row,
          ((col + 1) * COL_SIZE) + (2 * col),
          @col_divider
        ]
        @col_dividers << [
          row,
          ((col + 1) * COL_SIZE + 1) + (2 * col),
          @col_divider
        ]
      end
    end

    @buffer = []

    paint
  end

  def tick(state)
  end

  def render?
    false
  end

  def paint
    @buffer = []
    @buffer.concat(@row_dividers).concat(@col_dividers)

    # Add selections
    # Skew render
  end
end
