class Game
  attr_reader :size, :position, :selections

  PLAYER_ONE = :player_one
  PLAYER_TWO = :player_two

  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size) }
    @position = [0, 0]
    @taken_positions = {}
    @updated = false

    # TODO: probably should be a set here
    @selections = []
  end

  def tick(state)
    handle_input(state)
  end

  def updated?
    @updated
  end

  def handle_input(state)
    case state.key_pressed
    when InputQueue::RETURN
      if current_position_is_available?
        @selections << [@position[0], @position[1], player_turn(state)]
        @taken_positions[[@position[0], @position[1]]] = true

        update_player_turn(state)
      end
    when InputQueue::UP
      if @position[0] > 0
        @position[0] = @position[0] - 1
        @updated = true
      end
    when InputQueue::DOWN
      if @position[0] < @size - 1
        @position[0] = @position[0] + 1
        @updated = true
      end
    when InputQueue::LEFT
      if @position[1] > 0
        @position[1] = @position[1] - 1
        @updated = true
      end
    when InputQueue::RIGHT
      if @position[1] < @size - 1
        @position[1] = @position[1] + 1
        @updated = true
      end
    else
      @updated = false
    end
  end

  def current_position_is_available?
    !@taken_positions[@position]
  end

  def update_player_turn(state)
    state.player_turn = (state.player_turn == 0 ? 1 : 0)
  end

  def player_turn(state)
    state.player_turn == 0 ? PLAYER_ONE : PLAYER_TWO
  end
end
