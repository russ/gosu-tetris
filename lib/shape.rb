class Shape
  
  attr_reader :facing
  
  def initialize(window)
    @window = window
    @facing = 0
    @block_image = Gosu::Image.new(@window, File.dirname(__FILE__) + '/media/block.png', 1)
  end
  
  def rotate_clockwise
    facing_west? ? face_north : @facing += 1
  end
  
  def rotate_counter_clockwise
    facing_north? ? face_west : @facing -= 1
  end
  
  def directions
    [ :north, :east, :south, :west ]
  end
  
  def limit
    directions.size - 1
  end
  
  def facing_west?
    @facing == limit
  end
  
  def facing_north?
    @facing == 0
  end
  
  def face_north
    @facing = 0
  end
  
  def face_west
    @facing = limit
  end
  
  def face_east
    @facing = 1
  end
  
  def face_south
    @facing = 2
  end
  
  def block_size
    50
  end
  
  def render
    self.send("structure_#{ directions[@facing].to_s }").each_with_index do |row, pos_y|
      row.each_with_index do |col, pos_x|
        if col == 1
          @block_image.draw(pos_x * block_size, pos_y * block_size, 0)
        end
      end
    end
  end
  
end
