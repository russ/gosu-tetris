class Straight < Shape

	def initialize(window, grid)
		@color = Gosu::Color.new(0xff000000)
    @color.red = 0
    @color.green = 0
    @color.blue = 255
		super
	end
  
  def structure_north
    [
      [ 1 ],
      [ 1 ],
      [ 1 ],
      [ 1 ]
    ]
  end

  def structure_east
    [
      [ 1, 1, 1, 1 ]
    ]
  end

  def structure_south
    [
      [ 1 ],
      [ 1 ],
      [ 1 ],
      [ 1 ]
    ]
  end
	
  def structure_west
    [
      [ 1, 1, 1, 1 ]
    ]
  end
  
end
