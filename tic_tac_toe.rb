require_relative './lib/window'
require_relative './lib/fps'
require_relative './lib/game'
require_relative './lib/game_border'
require_relative './lib/diagnostics'
require_relative './lib/renderer'
require_relative './lib/game_loop'
require_relative './lib/game_board'
require_relative './lib/game_state'

class Main
  WINDOW_WIDTH  = 10
  WINDOW_HEIGHT = 10

  def initialize(
    window_width:  WINDOW_WIDTH,
    window_height: WINDOW_HEIGHT
  )
    @diagnostics   = true
    @window_width  = window_width
    @window_height = window_height
    @window        = initialize_window(window_width, window_height)
    @renderer      = Renderer.new(@window)

    @state         = GameState.new
  end

  def start
    GameLoop.start do |ticks, time_in_ms, fps, input|
      @state.key_pressed = input

      @renderer.render

      tick(ticks, time_in_ms, fps)

      @window.tick(@state)
    end
  end

  private

  # Game engine related tasks that happen per tick
  def tick(ticks, time_in_ms, fps)
    @state.ticks = ticks
    @state.time_in_ms = time_in_ms
    @state.fps = fps
  end

  def initialize_window(width, height)
    window = Window.new(width, @diagnostics ? height + 1 : height)

    window.add_element(Game.new(width, height), 0, 0)
    window.add_element(GameBorder.new(width, height), 0, 0)
#    window.add_element(GameBoard.new, 4, 4)

    if @diagnostics
      window.add_element(Diagnostics.new, @window_height, 0)
    end

    window
  end
end

Main.new(window_width: 30, window_height: 20).start
