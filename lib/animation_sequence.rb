class AnimationSequence
  def initialize(animations)
    @animations = animations.cycle
    @animation  = @animations.next

    @transitioning = false
  end

  # tick current animation, if finished then move to next
  def tick(time_in_ms)
    if @transitioning && @animation.finished?
      @animation = @animations.next
    end

    @animation.tick(time_in_ms)

    if @animation.finished? && !@animation.infinite?
      @transitioning = true
    else
      @transitioning = false
    end
  end

  # wait for current to finish then move to next
  def transitioning
    @transitioning = true
  end

  def transitioned?
    @animation.transitioned?
  end

  def tile
    @animation.tile
  end
end
