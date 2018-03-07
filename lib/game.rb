require_relative './game_state'
require_relative './board'
require_relative './pixel'
require_relative './win_calculator'
require_relative './player_selections'

class Game
  attr_reader :size, :player_position, :player_one_selections,
    :player_two_selections, :board

  PLAYER_ONE = :player_one
  PLAYER_TWO = :player_two

  def initialize(size)
    @size = size
    @board = Board.new(size)
    @player_position = [0, 0]
    @updated = false
    @player_one_selections = PlayerSelections.new(size, GameState::PLAYER_ONE)
    @player_two_selections = PlayerSelections.new(size, GameState::PLAYER_TWO)
    @win_calculator  = WinCalculator.new(size)

    @output = []
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
      if board.empty_cell?(@player_position)
        board.update_cell(@player_position.dup, state.player_turn)

        update_player_selections(state)
        update_game_state(state)
      end
    when InputQueue::UP
      if @player_position[0] > 0
        @player_position[0] = @player_position[0] - 1
        @updated = true
      end
    when InputQueue::DOWN
      if @player_position[0] < @size - 1
        @player_position[0] = @player_position[0] + 1
        @updated = true
      end
    when InputQueue::LEFT
      if @player_position[1] > 0
        @player_position[1] = @player_position[1] - 1
        @updated = true
      end
    when InputQueue::RIGHT
      if @player_position[1] < @size - 1
        @player_position[1] = @player_position[1] + 1
        @updated = true
      end
    else
      @updated = false
    end
  end

  # Update turns, check win condition, etc
  def update_game_state(state)
    if draw?(state)
      raise 'in draw'
      state.phase = GameState::DRAW
    elsif win?(state)
      raise 'in win'
      state.phase = GameState::WIN
    else
      state.phase = GameState::IN_PROGRESS

      state.player_turn = if state.player_turn == GameState::PLAYER_ONE
                            GameState::PLAYER_TWO
                          else
                            GameState::PLAYER_ONE
                          end
    end
  end

  def win?(state)
    selections = case state.player_turn
                 when GameState::PLAYER_ONE
                   @player_one_selections
                 when GameState::PLAYER_TWO
                   @player_two_selections
                 end

    @win_calculator.is_win?(selections.to_1d)
  end

  def draw?(state)
    @board.full? && !win?(state)
  end

  def update_player_selections(state)
    case state.player_turn
    when GameState::PLAYER_ONE
      @player_one_selections.add(
        Pixel.new(@player_position[0], @player_position[1])
      )
    when GameState::PLAYER_TWO
      @player_two_selections.add(
        Pixel.new(@player_position[0], @player_position[1])
      )
    end
  end
end
