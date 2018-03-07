# The WinCalculator class is responsible for determining if a board state
# reflects a win.
class WinCalculator
  def initialize(size)
    @size = size
  end

  def is_win?(state)
    !!winning_board_states[state]
  end

  private

  def winning_board_states
    @winning_board_states ||= begin
      total_length = @size * @size
      results = {}

      _generate_winning_board_states = ->(current, turns) {
        if current.length == total_length
          if turns <= 5 && state_contains_win?(current)
            results[current] = true
          end
        else
          _generate_winning_board_states.(current + '1', turns + 1)
          _generate_winning_board_states.(current + '0', turns)
        end
      }

      _generate_winning_board_states.('', 0)

      results
    end
  end

  def winning_indexes_list
    @winning_indexes_list ||= begin
      list = []
      base = '0' * @size * @size

      # rows, cols
      @size.times do |row|
        _row = []
        _col = []

        @size.times do |col|
          _row << (row * @size) + col
          _col << row + (col * @size)
        end

        list << _row
        list << _col
      end

      # Diagnol
      one = []
      two = []

      @size.times do |n|
        one << n * (@size + 1)
        two << n * (@size - 1) + (@size - 1)
      end

      list << one
      list << two

      list
    end
  end

  def state_contains_win?(state)
    found = false

    winning_indexes_list.each do |winning_indexes|
      if winning_indexes.all? { |index| state[index] == '1' }
        found = true
        break
      end
    end

    found
  end
end
