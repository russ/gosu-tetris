class Step < Shape
  
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
