require_relative './element'

class Diagnostics
  include Element
  extend Element

  def initialize
    @render       = false
    @counter      = 0
    @last_render  = 0
    @step_size_ms = 500
    @buffer       = []
  end

  def render?
    @render
  end

  def tick(state)
    if (state.time_in_ms - @last_render) > @step_size_ms
      @last_render = state.time_in_ms
      @render = true

      paint(state.fps)
    else
      @render = false
    end
  end

  def paint(fps)
    @buffer = [[0, 0, "FPS: #{fps}"]]
  end
end
