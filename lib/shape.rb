class Shape
  
  attr_reader :facing
  attr_reader :state

	attr_reader :top_x
	attr_reader :top_y
	attr_reader :bottom_x
	attr_reader :bottom_y

	attr_accessor :grid

  def initialize(window, grid)
    @window = window
    @grid = grid
		@state = :active
    @block_image = Gosu::Image.new(@window, File.dirname(__FILE__) + '/media/block.png', 1)
		set_color
		set_start_position
  end

	def self.random(window, grid)
		shapes = [ T, L, Straight, Square, Step ]
		shapes[rand(shapes.length)].new(window, grid)
	end

	def set_color
		@color = Gosu::Color.new(0xff000000)
    @color.red = rand(255 - 40) + 40
    @color.green = rand(255 - 40) + 40
    @color.blue = rand(255 - 40) + 40
	end

	def set_start_position(facing = 1, top_x = 5, top_y = 0)
    @facing = facing
    @top_x = top_x
    @top_y = top_y
		set_coordinates
	end

	def move_left
		unless @state == :stopped || @grid.intersect?(@top_x - 1, @top_y, @bottom_x - 1, @bottom_y)
			@top_x -= 1 
			@bottom_x -= 1 
		end
	end

	def move_right
		unless @state == :stopped || @grid.intersect?(@top_x + 1, @top_y, @bottom_x + 1, @bottom_y)
			@top_x += 1 
			@bottom_x += 1 
		end
	end

	def move_down
		unless @grid.intersect?(@top_x, @top_y + 1, @bottom_x, @bottom_y + 1)
			@top_y += 1 
			@bottom_y += 1 
		else
			@state = :stopped
		end
	end
  
  def rotate_clockwise
		unless @state == :stopped
    	facing_west? ? face_north : @facing += 1
			set_coordinates
		end
  end
  
  def rotate_counter_clockwise
		unless @state == :stopped
    	facing_north? ? face_west : @facing -= 1
			set_coordinates
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
    self.send("structure_#{ directions[@facing].to_s }").each_with_index do |row, pos_y|
      row.each_with_index do |col, pos_x|
        @block_image.draw((pos_x * block_size) + (@top_x * block_size) + @grid.left, (pos_y * block_size) + (@top_y * block_size), 0, 1, 1, @color) if col == 1
      end
    end
  end

	private

	def set_coordinates
		structure = self.send("structure_#{ directions[@facing].to_s }")
		width = structure[0].size
		height = structure.size
		@bottom_x = @top_x + width
		@bottom_y = @top_y + height
	end
  
end
