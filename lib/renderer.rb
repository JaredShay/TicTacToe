class Renderer
  def initialize
    @code   = %x{clear}
  end

  def render(window)
    return unless window.render?

    out = []

    window.buffer.each do |row|
      row.each do |val|
        out << val
      end

      out << "\n"
    end

    print @code
    puts out.join
  end
end
