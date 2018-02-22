class Animations
  def initialize(base_tile)
    @base_tile    = base_tile
    @queue        = []
  end

  def tick(time_in_ms)
    return if @queue.empty?

    current_animation.tick(time_in_ms)

    return unless current_animation.finished?

    if @queue.length > 1 || !current_animation.infinite?
      @queue.shift

      if @queue.empty?
        @queue << base_animation
      end
    end
  end

  def base_animation
    Animation.new([[Float::INFINITY, @base_tile]], infinite: true)
  end

  def tile
    current_animation.tile
  end

  def push(animation)
    @queue << animation
  end

  def transitioned?
    current_animation.transitioned?
  end

  def current_animation
    @queue[0]
  end
end
