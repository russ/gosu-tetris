require File.dirname(__FILE__) + '/../../lib/tetris'

describe Grid do

	before(:each) do
		@window = GameWindow.new
		@block_size = 25
		@x_offset = 25
		@y_offset = 25
		@grid = Grid.new(@window, :block_size => @block_size, :x_offset => 25, :y_offset => 25)
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
		@block_size = 25
		@x_offset = 25
		@y_offset = 25
		@grid = Grid.new(@window, :block_size => @block_size, :x_offset => 25, :y_offset => 25)
	end

	it "should know when a shape is intersecting" do
		# Doesn't intersect
		shape = mock("shape", :top_x => 0, :top_y => 0, :bottom_x => 1, :bottom_y => 1)
		@grid.intersects?(shape).should == false

		# Intersect on the left
		shape = mock("shape", :top_x => -1, :top_y => 0, :bottom_x => -1, :bottom_y => 1)
		@grid.intersects?(shape).should == true

		# Intersect on the right
		shape = mock("shape", :top_x => 10, :top_y => 0, :bottom_x => 1, :bottom_y => 12)
		@grid.intersects?(shape).should == true

		# Intersect on the bottom
		shape = mock("shape", :top_x => 0, :top_y => 15, :bottom_x => 0, :bottom_y => 16)
		@grid.intersects?(shape).should == true
	end

end
