require_relative './lib/window'
require_relative './lib/fps'
require_relative './lib/background'
require_relative './lib/border'
require_relative './lib/diagnostics'
require_relative './lib/renderer'
require_relative './lib/game_loop'
require_relative './lib/game_board'
require_relative './lib/game_state'
require_relative './lib/game_wrapper'
require_relative './lib/game'

class Main
  WINDOW_WIDTH    = 10
  WINDOW_HEIGHT   = 10
  GAME_BOARD_SIZE = 3

  def initialize(
    window_width:    WINDOW_WIDTH,
    window_height:   WINDOW_HEIGHT,
    game_board_size: GAME_BOARD_SIZE
  )
    @diagnostics     = true
    @window_width    = window_width
    @window_height   = window_height
    @game_board_size = game_board_size
    @state           = GameState.new
    @game            = Game.new(game_board_size)

    @window   = initialize_window(window_width, window_height)
    @renderer = Renderer.new(@window)
  end

  def start
    @renderer.render

    GameLoop.start do |ticks, time_in_ms, fps, input|
      @state.key_pressed = input
      @state.ticks       = ticks
      @state.time_in_ms  = time_in_ms
      @state.fps         = fps

      # Pass state to all registered elements
      @window.tick(@state)

      @renderer.render
    end
  end

  private

  def initialize_window(width, height)
    window = Window.new(width, @diagnostics ? height + 1 : height)

    window.add_element(Background.new(width, height), 0, 0)
    window.add_element(Border.new(width, height), 0, 0)
    window.add_element(
      GameBoard.new(width * 0.75, height * 0.75), height / 8, width / 8
    )
    window.add_element(
      GameWrapper.new(@game), height / 8 + 2, width / 8 + 4
    )

    if @diagnostics
      window.add_element(Diagnostics.new, @window_height, 0)
    end

    window
  end
end

Main.new(window_width: 80, window_height: 24).start
