class Game
  attr_reader :size, :position

  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size) }
    @position = [0, 0]
    @render = false
  end

  def tick(state)
    handle_input(state.key_pressed)
  end

  def render?
    @render
  end

  def handle_input(key_pressed)
    case key_pressed
    when InputQueue::UP
      if @position[0] > 0
        @position[0] = @position[0] - 1
        @render = true
      end
    when InputQueue::DOWN
      if @position[0] < @size - 1
        @position[0] = @position[0] + 1
        @render = true
      end
    when InputQueue::LEFT
      if @position[1] > 0
        @position[1] = @position[1] - 1
        @render = true
      end
    when InputQueue::RIGHT
      if @position[1] < @size - 1
        @position[1] = @position[1] + 1
        @render = true
      end
    else
      @render = false
    end
  end
end
