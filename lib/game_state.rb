# Value object that keeps track of the state of a game.
class GameState
  attr_accessor :ticks, :fps, :time_in_ms, :game_won, :player_turn, :key_pressed

  def initialize(
    fps:         0,
    ticks:       0,
    time_in_ms:  0.0,
    game_won:    false,
    key_pressed: nil
  )
    @ticks       = ticks
    @fps         = fps
    @time_in_ms  = time_in_ms
    @game_won    = game_won
    @player_turn = 0
    @key_pressed = key_pressed
  end
end
