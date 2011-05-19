class Node
  attr_accessor :left, :right, :data

  def initialize left=nil, right=nil, data
    @left = left
    @right = right
    @data = data
  end

  def to_s
    "#{@data}"
  end
end

class BinarySearchTree
  attr_accessor :root

  def initialize root=nil
    @root = root
  end

  def add data
    node = Node.new data

    if @root.nil?
      @root = node
    else
      current = @root

      while true
        if data < current.data
          if current.left.nil?
            current.left = node
            break
          else
            current = current.left
          end
        elsif data > current.data
          if current.right.nil?
            current.right = node
            break
          else
            current = current.right
          end
        else
          break
        end
      end
    end
  end
  
  def contains data
    found = false
    current = @root
    
    while not found and current
      if data < current.data
        current = current.left
      elsif data > current.data
        current = current.right
      else
        found = true
      end
    end
    
    found
  end
  
  def remove data
    found = false
    parent = null
    current = @root
    
    while not found and not current.nil?
      if data < current.data
        parent = current
        current = current.left
      elsif data > current.data
        parent = current
        current = current.right
      else
        found = true
      end
    end
    
    if found
      child_count = if current.left
      
end

bst = BinarySearchTree.new
bst.add(3)