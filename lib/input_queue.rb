class InputQueue
  UP    = :up
  DOWN  = :down
  RIGHT = :right
  LEFT  = :left

  def initialize
    @raw_queue = []
    @queue     = []
  end

  def enqueue(input)
    @raw_queue.push(input)

    parse_queue
  end

  # "\e"           == escape
  # "\e", "[", "A" == up_arrow
  # "\e", "[", "B" == down_arraw
  # "\e", "[", "C" == right_arrow
  # "\e", "[", "D" == left_arrow
  # " "            == space_bar
  def parse_queue
    input = nil

    if @raw_queue.length == 1
      case @raw_queue[0]
      when /\w/
        input = @raw_queue[0].to_sym
      when "\r"
        input = :return
      when " "
        input = :space
      end

      if @raw_queue[0] == "\e"
        # do nothing, possible starting of escape sequence
      else
        # flush queue, unknown or already handled character
        @raw_queue.clear
      end
    elsif @raw_queue.length == 2
      if @raw_queue[0] == "\e"
        if @raw_queue[1] == "["
          # possibly in an escape sequence
        else
          # remove the \e character as it is either an escape or the start of
          # an unknown escape sequence
          @raw_queue.shift

          # parse the queue again
          parse_queue
        end
      end
    elsif @raw_queue.length == 3
      # At this point the queue must be "\e", "["
      input = case @raw_queue[2]
              when "A" then UP
              when "B" then DOWN
              when "C" then RIGHT
              when "D" then LEFT
              end

      # flush queue, input is handled or unknown sequence
      @raw_queue.clear
    end

    @queue << input if input
  end

  def dequeue
    @queue.shift(1)[0]
  end
end
