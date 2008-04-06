class Step < Shape
  
  def initialize(window)
    super
  end
  
  def structure_north
    [
      [ 0, 1, 0 ],
      [ 1, 1, 0 ],
      [ 1, 0, 0 ]
    ]
  end
  
  def structure_east
    [
      [ 0, 0, 0 ],
      [ 0, 1, 1 ],
      [ 1, 1, 0 ]
    ]
  end
  
  def structure_south
    [
      [ 0, 1, 0 ],
      [ 0, 1, 1 ],
      [ 0, 0, 1 ]
    ]
  end
  
end