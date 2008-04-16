require 'date'
require 'digest/md5'

class Shape
  
  attr_reader :facing, :state, :blocks
	attr_accessor :position

  def initialize(window, grid)
    @window = window
    @grid = grid
		@facing = 0
		@state = :active
		@position = Coordinate.new(0, 0)
    @block_image = Gosu::Image.new(@window, File.dirname(__FILE__) + '/media/block.png', 1)
  end

	def self.random(window, grid)
		shapes = [ T, LLeft, LRight, Straight, Square, StepLeft, StepRight ]
		t = Time.now.to_f / (Time.now.to_f % Time.now.to_i)
  	random_seed = t * 1103515245 + 12345;
  	srand((random_seed / 65536) % 32768);
		shapes[rand(shapes.length)].new(window, grid)
	end

  def directions
    [ :north, :east, :south, :west ]
  end

	# Collision detection
	def can_move_to?(coor)
		return false if stopped?
		@blocks.each { |block| block.position! }
		@blocks.each do |block|
			return false if block.can_move_to?(coor) == false
		end
	end

	def move_left
		@position = Coordinate.new(@position.x - 1, @position.y) if can_move_to?(Coordinate.new(-1, 0))
	end

	def move_right
		@position = Coordinate.new(@position.x + 1, @position.y) if can_move_to?(Coordinate.new(1, 0))
	end
  
	def move_down
		if can_move_to?(Coordinate.new(0, 1))
			@position = Coordinate.new(@position.x, @position.y + 1)
		else
			@status = :stopped
		end
	end

	def move_to_grid
		@blocks.each { |block| @grid.block = block }
		@grid.blocks += @blocks
		@blocks = nil
	end

	def rotate(direction)
		@blocks.each { |block| block.position! }
		if direction == :clockwise
			@facing = (@facing == 3) ? 0 : @facing + 1
		else
			@facing = (@facing == 0) ? 3 : @facing - 1
		end
	end

	def active?
		@status == :active
	end

	def stopped?
		@status == :stopped
	end

  def render
		@blocks = []
    self.send("structure_#{ directions[@facing].to_s }").each_with_index do |row, pos_y|
      row.each_with_index do |col, pos_x|
				if col == 1
					block = Block.new(@window, @grid)
					block.position = Coordinate.new(pos_x + @position.x, pos_y + @position.y)
					block.color = @color
					block.render
					@blocks << block
				end
      end
    end
  end
  
end
