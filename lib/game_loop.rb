require_relative './fps'

# GameLoop handles the mechanics of the main game loop.
#
# Each loop yields the number of ticks, the elapsed time, and the frame rate.
class GameLoop
  FPS_SMOOTHING = 10.0

  def self.start(time: Time.now, &block)
    sleep 0.001 # hack to avoid / 0 on first game loop
    new(time).start.each(&block)
  end

  def initialize(time, fps_smoothing = FPS_SMOOTHING)
    @initial_time_ms = time_in_ms(time)
    @fps             = FPS.new(fps_smoothing)
  end

  def start
    Enumerator.new do |yielder|
      ticks = 0
      loop do
        ticks += 1
        elapsed_time_ms = time_in_ms(Time.now) - @initial_time_ms
        @fps.update(ticks, elapsed_time_ms)

        yielder << [ticks, elapsed_time_ms, @fps.out]
      end
    end
  end

  private

  def time_in_ms(time)
    (time.to_f * 1000.0).to_i
  end
end
