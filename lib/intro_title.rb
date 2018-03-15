require_relative './sprites/intro_title'

class IntroTitle
  attr_reader :buffer
  def initialize(width, height)
    @width = width
    @height = height

    @buffer = []

    # total length 167 + some padding for a space
    @title_length = 167
    @title_height = 16
    @col_offset = 0
    @animation_time_ms = 50
    @last_render_ms = 0
    @render = false

    paint
  end

  def tick(game_state)
    if game_state.time_in_ms > (@last_render_ms + @animation_time_ms)
      @col_offset += 1
      @last_render_ms = game_state.time_in_ms
      @render = true
      paint
    else
      @render = false
    end
  end

  def render?
    @render
  end

  def paint
    # clear buffer
    @buffer = []

    @width.times do |col_i|
      @title_height.times do |row_i|
        el = Sprites::INTRO_TITLE[row_i][(col_i + @col_offset) % @title_length]

        next if el == nil

        @buffer << [row_i, col_i, el]
      end
    end
  end
end
