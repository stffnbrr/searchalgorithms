class Field
  include Node
  
  def self.createboard size_x, size_y
    @@board = Array.new
    size_x.times do |value_x| 
      arr = Array.new
      size_y.times {|value_y| arr[value_y] = Random.new.rand 1..10}
      @@board[value_x] = arr
    end
    print "BOARD:"
    size_x.times{|value_x|
      print "\n"
      size_y.times {|value_y| print '%3d' %@@board[value_x][value_y]}
    }
    print "\n"
	@@board
  end
  
  attr_reader :x, :y

  def initialize x,y
    @x = x
    @y = y
  end
  
  def value 
    @@board[x][y]
  end
  
  def distance field 
    (self.x-field.x).abs+(self.y-field.y).abs
  end
  
  def == obj
    self.x == obj.x && self.y == obj.y    
  end
  
  def children
    arr = Array.new
    if x > 0
      arr = arr << Field.new(x-1,y)
    end
    if x < @@board.size-1
      arr = arr << Field.new(x+1,y)
    end   
    if y > 0
      arr = arr << Field.new(x,y-1)
    end
    if y < @@board[0].size-1
      arr = arr << Field.new(x,y+1)
    end
    arr.permutation.to_a[0]
  end
  
  def to_s
    "Field(#{x},#{y})"    
  end
end
