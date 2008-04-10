require 'pathname'
require 'gosu'

$: << Pathname.new(File.dirname(__FILE__)).realpath

require 'shape'
require 'shapes/step'
require 'shapes/t'
require 'shapes/l'
require 'shapes/square'
require 'shapes/straight'

class GameWindow < Gosu::Window
  
  def initialize
    super(640, 480, false)
    self.caption = 'Tetris'
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
    @shape.render
  end
  
  def button_down(id)
    close if Gosu::Button::KbReturn == id
  end
  
end

window = GameWindow.new
window.show
