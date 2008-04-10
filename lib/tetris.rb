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
    @shape = Straight.new(self)
  end
  
  def update
    if button_down? Gosu::Button::KbUp
      @shape.face_north
    end
    
    if button_down? Gosu::Button::KbRight
      @shape.face_east
    end
    
    if button_down? Gosu::Button::KbDown
      @shape.face_south
    end

    if button_down? Gosu::Button::KbLeft
      @shape.face_west
    end
  end
  
  def draw
    # @shape.render
		@grid.render
  end
  
  def button_down(id)
    close if Gosu::Button::KbReturn == id
  end
  
end

window = GameWindow.new
window.show
