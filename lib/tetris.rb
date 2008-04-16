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
		@grid = Grid.new(self)
		@last_time = 0
  end
 
  # Since this function gets called 60 times per seconds
	# it just get better input by incrementing a value.
	# The milliseconds function was to spotty to get a good
	# constant value to comapare against. You could possibly
	# factor it down, but then your spending more processing
	# time on that alone.	
  def update
		# Timing for the key input
		if @last_time % 3 == 0
			case (@button_state)
				when :up then @shape.rotate(:clockwise)
				when :left then @shape.move_left
				when :right then @shape.move_right
				when :down then @shape.move_down
			end
			@button_state = nil
		end

		# Timing for moving the pieces down
		@shape.move_down if @last_time % 60 == 0

		@last_time += 1
	end
  
  def draw
		@grid.render
		if @shape.nil? || @shape.stopped? 
			@shape.move_to_grid if @shape && @shape.stopped?
			exit! if @grid.overflowed?
			@shape = Shape.random(self, @grid)
		end
		@shape.render
  end
  
  def button_down(id)
    close if Gosu::Button::KbEscape == id
		@button_state = :up if Gosu::Button::KbUp == id
		@button_state = :left if Gosu::Button::KbLeft == id
		@button_state = :right if Gosu::Button::KbRight == id
		@button_state = :down if Gosu::Button::KbDown == id
	end
  
end
