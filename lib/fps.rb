class FPS
  def initialize(smoothing)
    @smoothing = smoothing
    @buffer    = []
  end

  def out
    return 0 if @buffer.empty?

    (@buffer.inject(:+) / @smoothing).round
  end

  def update(ticks, elapsed_time_ms)
    @buffer << (ticks / (elapsed_time_ms / 1000.0))

    @buffer.shift if @buffer.length == @smoothing
  end
end
