class Grid

	attr_accessor :block_size
	attr_accessor :x_offset
	attr_accessor :y_offset
	attr_accessor :shapes

	def initialize(window, options = {})
		@window = window
    @block_image = Gosu::Image.new(@window, File.dirname(__FILE__) + '/media/block.png', 1)

		@block_size = options.key?(:block_size) ? options.delete(:block_size) : 25
		@x_offset = options.key?(:x_offset) ? options.delete(:x_offset) : 25
		@y_offset = options.key?(:y_offset) ? options.delete(:y_offset) : 25
	end

	def render
    grid.each_with_index do |row, pos_y|
      row.each_with_index do |col, pos_x|
        @block_image.draw((pos_x * block_size) + @x_offset, (pos_y * block_size) + @y_offset, 0) if col == 1
      end
    end
	end

	def top
		@x_offset
	end

	def right
		@x_offset + (@block_size * (grid[0].size - 2))
	end

	def bottom
		@y_offset + (@block_size * (grid.size - 1))
	end

	def left
		@x_offset + @block_size
	end

	def intersect?(shape)
		# Check for intersection on existing shapes
		@shapes.each { |s| return true if shape.intersect?(s) }

		# Check for intersection of the sides of the grid
		coors = shape.in_space
		coors[0][0] < 0 || coors[3][0] > (grid[0].size - 3) || coors[3][1] > (grid.size - 1)
	end

	private

	def grid
		[
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ]
		]
	end

end
