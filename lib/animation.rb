class Animation
  def initialize(states, infinite: false)
    @length                  = states.length
    @states                  = states.cycle
    @curr_state_pos          = 0
    @state                   = @states.next
    @infinite                = infinite
    @transitioned            = true
  end

  def finished?
    @curr_state_pos == (@length - 1)
  end

  def infinite?
    @infinite
  end

  def tick(time_in_ms)
    @time_of_state_change_ms ||= time_in_ms

    if (time_in_ms - @time_of_state_change_ms) >= transition_time_ms
      @time_of_state_change_ms = time_in_ms
      @state                   = @states.next
      @transitioned            = true

      if finished?
        @curr_state_pos = 0
      else
        @curr_state_pos += 1
      end
    else
      @transitioned = false
    end
  end

  def transitioned?
    @transitioned
  end

  def tile
    @state[1]
  end

  def transition_time_ms
    @state[0]
  end
end
