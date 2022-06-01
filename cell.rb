
class Cell
  attr_accessor :alive

  def initialize(x_pos:, y_pos:, alive: false)
    @x_pos = x_pos
    @y_pos = y_pos
    @alive = alive
    @alive_next = false
  end

  def tick(alive_count:)
    if alive
      @alive_next = [2, 3].include?(alive_count)
      return
    end
    @alive_next = true if alive_count == 3
  end

  def update
    @alive = @alive_next
  end

  def location
    [@x_pos, @y_pos]
  end

  def draw
    print alive ? '▓' : '░'
  end
end
