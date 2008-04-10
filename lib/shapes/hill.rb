class T < Shape
  
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
    ].each_with_index do |row, pos_y|
      row.each_with_index do |col, pos_x|
        if col == 1
          @block_image.draw(pos_x * block_size, pos_y * block_size, 0)
        end
      end
    end
  end
  
end