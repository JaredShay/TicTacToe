class Pixel
  attr_reader :row, :col

  def initialize(row, col)
    @row    = row
    @col    = col
  end

  def to_1d(size)
    @row * size + @col
  end
end
