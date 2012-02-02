module Node 
  attr_accessor :target, :parent

  def path
    parent.nil? ? [self] : parent.path << self
  end
  
  def path_cost 
    parent.nil? ? 0 : parent.path_cost + value
  end

  def is_target?
    self == self.target
  end

  def find generate_children,&block
    @list = [self]
    not_found = true
    while @list.size > 0 && not_found
      current = @list.delete_at(0)
      if current.is_target? 
        not_found = false
      else
        @list += generate_children.call(current)
        @list.sort! &block 
        @list
      end
    end
    current
 end

 def get_children parent
    ch_arr = parent.children
    ch_arr.reject! {|item| parent.path.include?(item)}
    ch_arr.each do |child|
      child.parent= parent
      child.target= target
    end
 end

 def breadth_first target
    self.target= target
    generate_children = lambda {|parent| get_children parent }
    find(generate_children) {|node1,node2| node1.path.size <=> node2.path.size }
  end
  

  
  def breadth_first_minimal_cost target
    self.target= target
    generate_children = lambda {|parent| get_children parent }
    find generate_children do  |node1, node2| 
      if (node1.path.size <=> node2.path.size) == 0 
        node1.value <=> node2.value 
      else 
        node1.path.size <=> node2.path.size 
      end
    end
  end
  
  def hillclimbing target
    self.target= target
    generate_children = lambda do |parent| 
      ch_arr = get_children parent
      ch = ch_arr.min_by {|child| child.value }
      if ch.nil?
        return Array.new
      end
      ch.parent = parent
      ch.target= parent.target
      [ch]
    end
    find(generate_children) {|node1,node2| 0}
  end
  

  def hillclimbing_backtracking target
    self.target= target
    generate_children = lambda {|parent| get_children parent}
    find generate_children do |node1,node2| 
      if node1.path.size < node2.path.size
        1
      elsif node1.path.size > node2.path.size
        -1
      else 
        node1.value <=> node2.value
      end
    end
  end
  
  def best_first target
    self.target= target
    generate_children = lambda {|parent| get_children parent }
    find generate_children do |node1,node2| 
      if node1.path.size < node2.path.size
        1
      elsif node1.path.size > node2.path.size
        -1
      else 
        node1.distance(node1.target)*node1.value <=> node2.distance(node1.target)*node2.value
      end
    end
  end
  

  
  def depth_first target
    self.target= target
    generate_children = lambda {|parent| get_children parent }
    find generate_children do |node1,node2| 
      if node1.path.size < node2.path.size
        1
      elsif node1.path.size > node2.path.size
        -1
      else 
        0
      end
    end
  end
  

 def depth_first_limit target 
    self.target= target
    @@limit = 1
    generate_children = lambda do |parent| 
      if parent.path.size <= @@limit 
        get_children(parent) 
      else 
        @@limit = @@limit + 3
        []
      end
    end
    find generate_children do |node1,node2| 
      if node1.path.size < node2.path.size
        1
      elsif node1.path.size > node2.path.size
        -1
      else 
        0
      end
    end
  end 
  
  def a_algo target
    self.target= target
    generate_children = lambda {|parent| get_children parent }
    find generate_children do |node1,node2| 
      (node1.path_cost + node1.distance(node1.target)*node1.value) <=> (node2.path_cost + node2.distance(node2.target)*node2.value)
    end  
  end
  
end
