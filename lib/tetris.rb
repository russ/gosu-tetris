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
  opts.on("-f", nil, "Run in fullscreen") do |f|
    $options[:fullscreen] = f
  end
end.parse!

class GameWindow < Gosu::Window
  
  def initialize
    super(640, 480, $options[:fullscreen])
    self.caption = 'Tetris'
    @grid = Grid.new(self)
		@shapes = []
  end
  
  def update
    if button_down? Gosu::Button::KbLeft
      @active_shape.move_left
    end

    if button_down? Gosu::Button::KbRight
      @active_shape.move_right
    end

    if button_down? 97 # A
      @active_shape.rotate_clockwise
    end

    if button_down? 115 # S
      @active_shape.rotate_counter_clockwise
    end
    
    # if button_down? Gosu::Button::KbDown
    #   @shape.face_south
    # end
  end
  
  def draw
		@grid.render

		@active_shape = Shape.random(self) if @active_shape.nil?
		if @active_shape.stopped?
    	@shapes << @active_shape
			@active_shape = Shape.random(self)
    	@active_shape.render
		end

		@active_shape.render
		@shapes.each { |s| s.render }
  end
  
  def button_down(id)
    close if Gosu::Button::KbEscape == id
  end
  
end

window = GameWindow.new
window.show
