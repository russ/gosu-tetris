require 'gosu'
require 'shape'
require 'step'

class GameWindow < Gosu::Window
  
  def initialize
    super(640, 480, false)
    self.caption = 'Tetris'
    @shape = Step.new(self)
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