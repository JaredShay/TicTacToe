class FPS
  def initialize(smoothing)
    @smoothing = smoothing
    @buffer    = []
  end

  def out
    return 0 if @buffer.empty?

    # This calculation is wrong when the buffer is `smoothing - 1`. It
    # stabalizes quickly enough to not be an issue.
    (@buffer.inject(:+) / @smoothing).round
  end

  def update(ticks, elapsed_time_ms)
    @buffer << (ticks / (elapsed_time_ms / 1000.0))

    @buffer.shift if @buffer.length == @smoothing
  end
end
