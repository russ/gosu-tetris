require File.dirname(__FILE__) + '/../../lib/tetris'

describe Grid do

	before(:each) do
		@window = GameWindow.new
		@grid = Grid.new(@window, :block_size => 25, :x_offset => 25, :y_offset => 25)
	end

	it "should know its top y coordinate" do
		@grid.top.should == 25
	end

	it "should know its right x coordinate" do
		@grid.right.should == 275
	end

	it "should know its bottom y coordinate" do
		@grid.bottom.should == 425
	end

	it "should know its left x coordinate" do
		@grid.left.should == 50
	end

end

describe "Grid when interacting with a shape" do

	before(:each) do
		@window = GameWindow.new
		@grid = Grid.new(@window, :block_size => 25, :x_offset => 25, :y_offset => 25)
	end

	it "should know when a shape is intersecting" do
		# Doesn't intersect
		@grid.intersect?(0, 0, 1, 1).should == false

		# Intersect on the left
		@grid.intersect?(-1, 0, -1, 1).should == true

		# Intersect on the right
		@grid.intersect?(10, 0, 1, 12).should == true

		# Intersect on the bottom
		@grid.intersect?(0, 15, 0, 16).should == true
	end

end
