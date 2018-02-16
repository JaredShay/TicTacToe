class Renderer
  def initialize(window)
    @window = window
    @code   = %x{clear}
  end

  def render
    return unless @window.render?

    out = []

    @window.buffer.each do |row|
      row.each do |val|
        out << val
      end

      out << "\n"
    end

    print @code
    puts out.join
  end
end
