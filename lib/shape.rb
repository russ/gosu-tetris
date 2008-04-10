class Shape
  
  attr_reader :facing
  attr_reader :state
  attr_reader :current_x
  attr_reader :current_y
  
  def initialize(window)
    @window = window
    @facing = 0
		@state = :active
    @current_x = 4
    @current_y = -3
    @block_image = Gosu::Image.new(@window, File.dirname(__FILE__) + '/media/block.png', 1)
  end

	def self.random(window)
		shapes = [ T, L, Straight, Square, Step ]
		shapes[rand(shapes.length)].new(window)
	end

	def move_left
		@current_x -= 1 unless @current_x == 0 || @state == :stopped
	end

	def move_right
		@current_x += 1 unless @current_x == 8 || @state == :stopped
	end
  
  def rotate_clockwise
		unless @state == :stopped
    	facing_west? ? face_north : @facing += 1
		end
  end
  
  def rotate_counter_clockwise
		unless @state == :stopped
    	facing_north? ? face_west : @facing -= 1
		end
  end

	def stopped?
		@state == :stopped
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
    25
  end
  
  def render
		unless @current_y >= 15
			@current_y += 1 
		else
			@state = :stopped
		end

    self.send("structure_#{ directions[@facing].to_s }").each_with_index do |row, pos_y|
      row.each_with_index do |col, pos_x|
        if col == 1
          @block_image.draw((pos_x * block_size) + (@current_x * block_size) + block_size, (pos_y * block_size) + (@current_y * block_size), 0)
        end
      end
    end
  end
  
end
