class Board
  def initialize(size)
    @board           = Array.new(size) { Array.new(size) }
    @size            = size
    @taken_positions = {}
    @output = []
  end

  def cells
    Enumerator.new do |yielder|
      @taken_positions.each do |pos, val|
        yielder << [pos[0], pos[1], val]
      end
    end
  end

  def empty_cell?(position)
    !@taken_positions[position]
  end

  def update_cell(position, value)
    @board[position[0]][position[1]] = value

    @taken_positions[position] = value
  end

  def full?
    @taken_positions.length == @size
  end
end
