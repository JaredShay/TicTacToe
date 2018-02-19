class Window
  attr_reader :buffer

  def initialize(width, height)
    @width    = width
    @height   = height
    @buffer   = Array.new(@height) { Array.new(@width) }
    @elements = []
    @render   = true
  end

  def add_element(element, offset_row, offset_col)
    @elements << [element, offset_row, offset_col]
  end

  def tick(state)
    @render = false

    @elements.each do |element, offset_row, offset_col|
      element.tick(state)

      if element.render?
        @render = true
        render_element_at(element, offset_row, offset_col)
      end
    end
  end

  def render?
    @render
  end

  def render_element_at(el, offset_row, offset_col)
    el.buffer.each do |row, col, val|
      next if row + offset_row >= @height || col + offset_col >= @width

      @buffer[row + offset_row][col + offset_col] = val
    end
  end
end

