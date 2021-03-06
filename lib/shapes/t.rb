class T < Shape

	def initialize(window, grid)
		@color = Gosu::Color.new(0xff000000)
    @color.red = 255
    @color.green = 255
    @color.blue = 0
		super
	end
  
  def structure_north
    [
      [ 0, 1, 0 ],
      [ 1, 1, 1 ]
    ]
  end

  def structure_east
    [
      [ 1, 0 ],
      [ 1, 1 ],
      [ 1, 0 ]
    ]
  end

  def structure_south
    [
      [ 1, 1, 1 ],
      [ 0, 1, 0 ],
    ]
  end

  def structure_west
    [
      [ 0, 1 ],
      [ 1, 1 ],
      [ 0, 1 ]
    ]
  end
  
end
