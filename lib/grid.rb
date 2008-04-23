class Grid

	attr_accessor :block_size
	attr_accessor :x_offset
	attr_accessor :y_offset
	attr_accessor :shapes
	attr_accessor :blocks

	def initialize(window, options = {})
		@window = window
    @block_image = Gosu::Image.new(@window, File.dirname(__FILE__) + '/media/block.png', 1)

		@blocks = []
		@block_size = options.key?(:block_size) ? options.delete(:block_size) : 25
		@x_offset = options.key?(:x_offset) ? options.delete(:x_offset) : 25
		@y_offset = options.key?(:y_offset) ? options.delete(:y_offset) : 25

		@grid = empty_grid
	end

	# Pixel size of the block image
	def block_size
		25
	end

	# X Pixel coordinate for grid location
	def pixel_x_at(x)
		(block_size * x) + @x_offset + block_size
	end

	# Y Pixel coordinate for grid location
	def pixel_y_at(y)
		(block_size * y) + @y_offset
	end

	# Sets a block in the grid
	def block=(block)
		@grid[block.position.y][block.position.x] = 1
	end

	# Unsets a block in the grid
	def block!(block)
		@grid[block.position.y][block.position.x] = 0
		@blocks.delete_if { |b| block == b }
	end

	# Collision detection
	def block_at?(coor)
		return true if coor.x < 0 
		return true if coor.x > empty_grid[0].size - 1
		return true if coor.y >= empty_grid.size
		return true if @grid[coor.y][coor.x] == 1
		return false
	end

	# Not quite accurate
	def overflowed?
		@grid[0].each { |col| return true if col == 1 }
		return false
	end

	def remove_filled_rows
		@grid.each_with_index do |row, y|
			if is_filled_row(row)
				@grid[y].each_with_index do |i,x| 
					block = block_at(Coordinate.new(x, y))
					block!(block) unless block.nil?
				end

				@grid.reverse.each_with_index do |row, y|
					row.each_with_index do |block, x|
				 		coor = Coordinate.new(0, 1)
						block = block_at(Coordinate.new(x, (y - (empty_grid.size - 1)).abs))
						unless block.nil?
							# while block.can_move_to?(coor)
								new_coor = Coordinate.new(block.position.x, block.position.y + 1)
				 				block.position!
				 				block.position = new_coor
								@blocks << block
							# end
						end
					end
				end
			end
		end
	end

	def render
		grid = empty_grid
		# Y Blocks
		grid.size.times do |i|
    	@block_image.draw(@x_offset, (i * block_size) + @y_offset, 0)
    	@block_image.draw((grid[0].size * block_size + @x_offset + block_size), (i * block_size) + @y_offset, 0)
		end
		# X Blocks
		(grid[0].size + 2).times do |i|
    	@block_image.draw((i * block_size) + @x_offset, (grid.size * block_size) + @y_offset, 0)
		end
		@blocks.each { |block| block.render }
	end

	def to_s
		out = ""
		@grid.each do |row|
			out << "-------------------------------\n"
			row.each { |col| out << "|#{col}" }
			out << "\n-------------------------------\n"
		end
		return out
	end

	private

	def empty_grid
		[
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
		]
	end

	def is_filled_row(row)
		row.each { |x| return false if x == 0 }
		return true
	end

	def block_at(coor)
		block = @blocks.select do |block| 
			block.position.x == coor.x && block.position.y == coor.y
		end
		return block.first unless block.first.nil?
	end

end
