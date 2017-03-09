class Spiral
  def initialize(grid:, origin: :top_left)
    @grid = grid.rows.empty? ? [] : grid

    start_point origin
  end

  def to_a(clockwise: true)
    return @grid if @grid.empty?

    reverse_grid unless clockwise

    generate_spiral

    @spiral.flatten
  end

  def reverse_grid
    @grid = @grid.reflect
    @grid = @grid.rotate
  end

  def add_next_line
    @spiral << @rest.first

    @rest.rest.rotate clockwise: false
  end

  def generate_spiral
    @spiral = @grid.first
    @rest = @grid.rest.rotate clockwise: false

    @rest = add_next_line until @rest.first.nil?
  end

  def start_point(origin)
    case origin
    when :top_right
      @grid = @grid.rotate clockwise: false
    when :bottom_right
      @grid = @grid.rotate.rotate
    when :bottom_left
      @grid = @grid.rotate
    end
  end
end
