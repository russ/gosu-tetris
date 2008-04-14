class Block

	attr_accessor :color

	def initialize(window, grid)
		@window = window
		@grid = grid
		@position = Coordinate.new(0, 0)
    @block_image = Gosu::Image.new(@window, File.dirname(__FILE__) + '/media/block.png', 1)
	end

	def position
		@position
	end

	def position=(coor)
		@position = coor
		@grid.block = self
	end

	def position!
		@grid.block!(self)
	end

	def can_move_to?(coor)
		!@grid.block_at?(Coordinate.new(@position.x + coor.x, @position.y + coor.y))
	end
	
	def render
		@block_image.draw(@grid.pixel_x_at(@position.x), @grid.pixel_y_at(@position.y), 0, 1, 1, @color)
	end

end
