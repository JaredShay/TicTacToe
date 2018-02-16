require_relative './element'

class Diagnostics
  include Element

  def initialize
    @render = false
    @counter = 0
  end

  def render?
    @render
  end

  def update(_, fps)
    @counter += 1

    # Arbritrary count here to stop re-rendering on every tick
    if @counter == 5000
      @counter = 0
      paint(fps)

      @render = true
    else
      @render = false
    end
  end

  def paint(fps)
    @buffer = [[0, 0, "FPS: #{fps}"]]
  end
end
