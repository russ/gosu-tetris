require 'pathname'
require 'optparse'
require 'gosu'

# Include the current lib directory in the include path
$: << Pathname.new(File.dirname(__FILE__)).realpath

require 'grid'
require 'coordinate'
require 'block'
require 'shape'
require 'shapes/step_left'
require 'shapes/step_right'
require 'shapes/t'
require 'shapes/l_left'
require 'shapes/l_right'
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

		@shapes = []
		@grid = Grid.new(self)
		@cur_sec = 0
  end
  
  def update
		now = Gosu::milliseconds

		current_shape.move_left						if button_down? Gosu::Button::KbLeft
 		current_shape.move_right					if button_down? Gosu::Button::KbRight
 		current_shape.move_down						if button_down? Gosu::Button::KbDown
		current_shape.rotate(:clockwise)	if button_down? Gosu::Button::KbUp

		if @cur_sec / 1000 != now / 1000
			current_shape.move_down
			@cur_sec = now
		end
	end
  
  def draw
		@grid.render
		if current_shape.nil? || current_shape.stopped? 
			exit! if @grid.overflowed?
			@shapes << Shape.random(self, @grid)
		end
		@shapes.each { |s| s.render }
  end
  
  def button_down(id)
    close if Gosu::Button::KbEscape == id
  end

	private

	def current_shape
		@shapes.last
	end
  
end
