require_relative './fps'
require_relative './input_queue'
require 'io/console'

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
    @input_queue     = InputQueue.new
  end

  def start
    set_terminal_options

    input_thread = Thread.new do
      while(c = STDIN.getc) do
        handle_exit if c == "\u0003"

        @input_queue.enqueue(c)
      end
    end

    Enumerator.new do |yielder|
      ticks = 0
      loop do
        input = @input_queue.dequeue

        ticks += 1
        elapsed_time_ms = time_in_ms(Time.now) - @initial_time_ms
        @fps.update(ticks, elapsed_time_ms)

        yielder << [ticks, elapsed_time_ms, @fps.out, input]
      end
    end
  end

  private

  def time_in_ms(time)
    (time.to_f * 1000.0).to_i
  end

  def handle_exit
    unset_terminal_options

    exit(1)
  end

  def set_terminal_options
    # raw   - read characters without using return
    # opost - remove all post processing
    # echo  - don't echo back characters
    system("stty raw opost -echo")
  end

  def unset_terminal_options
    # raw   - read characters without using return
    # opost - remove all post processing
    # echo  - don't echo back characters
    system("stty -raw echo")
  end
end
