require_relative './lib/window'
require_relative './lib/fps'
require_relative './lib/game'
require_relative './lib/game_border'
require_relative './lib/diagnostics'
require_relative './lib/renderer'
require_relative './lib/game_loop'
require_relative './lib/game_board'

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
  end

  def start
    GameLoop.start do |ticks, time_in_ms, fps|
      @window.update_elements(time_in_ms, fps)

      @renderer.render
    end
  end

  private

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

Main.new(window_width: 60, window_height: 40).start
