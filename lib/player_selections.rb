class PlayerSelections
  include Enumerable

  def initialize(size, player)
    @size = size

    @_1d_representation = "0" * size * size
    @selections         = []
  end

  def each(&block)
    @selections.each do |selection|
      block.call(selection)
    end
  end

  def add(selection)
    @selections << selection

    # Used for win condition check, this could be lazy eval'd too
    @_1d_representation[selection.to_1d(@size)] = "1"

    nil
  end

  def to_1d
    @_1d_representation
  end
end
