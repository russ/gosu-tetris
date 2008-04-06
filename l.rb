class L < Shape
  
  def initialize(window)
    super
    @poses = []
  end
  
  def draw
    case @direction
    when :north: render_north
    when :east: render_east
    when :south: render_south
    when :west: render_west
    end
  end
  
  def render_north
    [
      [ 0, 1, 0 ],
      [ 1, 1, 0 ],
      [ 1, 0, 0 ]
    ]
  end
  
end