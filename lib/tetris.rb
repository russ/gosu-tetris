require 'pathname'
require 'optparse'
require 'gosu'

# Include the current lib directory in the include path
$: << Pathname.new(File.dirname(__FILE__)).realpath

require 'grid'
require 'shape'
require 'shapes/step'
require 'shapes/t'
require 'shapes/l'
require 'shapes/square'
require 'shapes/straight'

# Command Line Options
$options = { :fullscreen => false }
OptionParser.new do |opts|
  opts.banner = "Usage: gosu-tetris [options]"
  opts.on("-f", nil, "Run in fullscreen") { |v| $options[:fullscreen] = v }
  opts.on("-s N", Integer, "Game Speed (1-6)") { |v| $options[:speed] = v }
end.parse!

class GameWindow < Gosu::Window
  
  def initialize
    super(640, 480, $options[:fullscreen])
    self.caption = 'Tetris'
    @grid = Grid.new(self)
		@shapes = []
		@speed = $options[:speed]
		@speed ||= 1
		@count = 0
  end
  
  def update
		# Control the speed up the update
		if @count % 5 == 0
    	if button_down? Gosu::Button::KbLeft
    	  @active_shape.move_left
    	end

    	if button_down? Gosu::Button::KbRight
    	  @active_shape.move_right
    	end

    	if button_down? Gosu::Button::KbDown
    	  @active_shape.move_down
    	end

    	if button_down? Gosu::Button::KbUp
    	  @active_shape.rotate_clockwise
    	end

    	if button_down? 97 # A
    	  @active_shape.rotate_clockwise
    	end

    	if button_down? 115 # S
    	  @active_shape.rotate_counter_clockwise
    	end
		end

		@active_shape.move_down if @count % (60 - ((@speed - 1) * 10)) == 0
		@count += 1
  end
  
  def draw
		@grid.render

		@active_shape = Shape.random(self, @grid) if @active_shape.nil?
		if @active_shape.stopped?
    	@shapes << @active_shape
			@active_shape = Shape.random(self, @grid)
		end

		@active_shape.render
		@shapes.each { |s| s.render }
  end
  
  def button_down(id)
    close if Gosu::Button::KbEscape == id
  end
  
end
