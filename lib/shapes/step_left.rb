class StepLeft < Shape

	def initialize(window, grid)
		@color = Gosu::Color.new(0xff000000)
    @color.red = 0
    @color.green = 255
    @color.blue = 0
		super
	end
  
  def structure_north
    [
      [ 0, 1 ],
      [ 1, 1 ],
      [ 1, 0 ]
    ]
  end
  
  def structure_east
    [
      [ 1, 1, 0 ],
      [ 0, 1, 1 ]
    ]
  end
  
  def structure_south
    [
      [ 0, 1 ],
      [ 1, 1 ],
      [ 1, 0 ]
    ]
  end

  def structure_west
    [
      [ 1, 1, 0 ],
      [ 0, 1, 1 ]
    ]
  end
  
end
