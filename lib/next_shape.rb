class NextShape < Grid

	attr_accessor :block_size
	attr_accessor :x_offset
	attr_accessor :y_offset
	attr_accessor :shape

	def initialize(window, options = {})
		@window = window
    @block_image = Gosu::Image.new(@window, File.dirname(__FILE__) + '/media/block.png', 1)

		@block_size = options.key?(:block_size) ? options.delete(:block_size) : 25
		@x_offset = options.key?(:x_offset) ? options.delete(:x_offset) : 365
		@y_offset = options.key?(:y_offset) ? options.delete(:y_offset) : 25
	end

	def render
    grid.each_with_index do |row, pos_y|
      row.each_with_index do |col, pos_x|
        @block_image.draw((pos_x * block_size) + @x_offset, (pos_y * block_size) + @y_offset, 0) if col == 1
      end
    end
		@shape.grid = self
		@shape.set_start_position(1, 2, 3)
		@shape.render
	end

	private

	def grid
		[
			[ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 ],
			[ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ]
		]
	end

end
