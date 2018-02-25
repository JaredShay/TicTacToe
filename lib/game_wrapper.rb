require_relative './color'

# Wrap a game object to handle presentation logic
class GameWrapper
  include Color

  COL_SIZE         = 11
  COL_DIVIDER_SIZE = 2
  ROW_SIZE         = 4
  ROW_DIVIDER_SIZE = 1

  attr_reader :buffer
  def initialize(game)
    @game = game
    @size = game.size

    @length = (COL_SIZE * @size) + ((@size - 1) * COL_DIVIDER_SIZE)
    @height = (ROW_SIZE * @size) + ((@size - 1) * ROW_DIVIDER_SIZE)

    @row_dividers = []
    (@size - 1).times do |row|
      @length.times do |col|
        @row_dividers << [
          ((row + 1) * (ROW_SIZE + ROW_DIVIDER_SIZE) - 1),
          col,
          color('-', :blue, :black)
        ]
      end
    end

    @col_divider = color('/', :blue, :black)
    @col_dividers = []
    @height.times do |row|
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

    @selection_mapping = {
      [0,0] => [0,0],
      [0,1] => [0,13],
      [0,2] => [0,26],
      [1,0] => [5,0],
      [1,1] => [5,13],
      [1,2] => [5,26],
      [2,0] => [10,0],
      [2,1] => [10,13],
      [2,2] => [10,26],
    }

    paint
  end

  def tick(state)
    @game.tick(state)

    paint if @game.render?
  end

  def render?
    @game.render?
  end

  def paint
    @buffer = []
    @buffer.concat(@row_dividers.map(&:dup)).concat(@col_dividers.map(&:dup))

    # Add selections

    # Add position
    position = @selection_mapping[@game.position]
    # Top and bottom rows of selection
    COL_SIZE.times do |n|
      @buffer << [position[0], n + position[1], color('-', :green, :green)]
      @buffer << [position[0] + ROW_SIZE - 1, n + position[1], color('-', :green, :green)]
    end
    # left and right rows
    ROW_SIZE.times do |n|
      @buffer << [position[0] + n, position[1], color('/', :green, :green)]
      @buffer << [position[0] + n, position[1] + 1, color('/', :green, :green)]
      @buffer << [position[0] + n, position[1] + COL_SIZE - 1, color('/', :green, :green)]
      @buffer << [position[0] + n, position[1] + COL_SIZE, color('/', :green, :green)]
    end
    #@buffer << [position[0], position[1], 'P']

    # Skew render
    @buffer.each do |pixel|
      pixel[1] = pixel[1] + ((@height - 1) - pixel[0])
    end
  end
end
