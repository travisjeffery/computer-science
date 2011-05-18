class Node
  @left
  @right
  @data
  
  Node = (left, right, data) ->
    @left = left
    @right = right
    @data = data

Node::toString = () ->
  return @data.toString()

class BinarySearchTree
  
  BinarySearchTree = () ->
    @root = null
    
BinarySearchTree::add = (data) ->
  node = new Node(null, null, data)
    
  if @root is null
    @root = node
  else
    current = @root
    
    while true
      if data < current.data
        if current.left is null
          current.left = node
          break
        else
          current = current.left
      else if data > current.data
        if current.right is null
          current.right = node
          break
        else
          current = current.right
      else
        break

BinarySearchTree::contains = (data) ->
  found = false
  current = @root
  
  while not found and current
    if data < current.data
      current = current.left
    else if data > current.data
      current = current.right
    else
      found = true
      
  found

BinarySearchTree::remove = (data) ->
  found = false
  parent = null
  current = @root
  
  while not found and current?
    if data < current.data
      parent = current
      current = current.left
    else if data > current.data
      parent = current
      current = current.right
    else
      found = true
  
  if found
    childCount = (if current.left isnt null then 1 else 0) + (if current.right isnt null then 1 else 0)
    
    if current is @root
      switch childCount
        when 0
          @root = null
          break
        when 1
          @root = if current.right is null then current.left else current.right
          break
        when 2
          replacement = @root.left
          
          while replacement.right isnt null
            replacementParent = replacement
            replacement = replacement.right
          
          if replacementParent isnt null
            replacementParent.right = replacement.left
            replacement.right = @root.right
            replacement.left = @root.left
          else
            replacement.right = @root.right
          
          @root = replacement
          
    else
      switch childCount
        when 0
          if current.data < parent.data
            parent.left = null
          else
            parent.right = null
          break
        when 1
          if current.data < parent.data
            parent.left = if current.left is null then current.right else current.left
          else
            parent.right = if current.left is null then current.right else current.left
          break
        when 2
          replacement = current.left
          replacementParent = current
          
          while replacement.right isnt null
            replacementParent = replacement
            replacement = replacement.right
            
          replacementParent.right = replacement.left
          
          replacement.right = current.right
          replacement.left = current.left
          if current.data < parent.data
            parent.left = replacement
          else
            parent.right = replacement

BinarySearchTree::size = () ->
  length = 0
  @traverse (node) -> length++
  length

BinarySearchTree::toArray = () ->
  result = []
  @traverse((node) -> result.push node.data)
  result

BinarySearchTree::toString = () ->
  return @toArray().toString()

BinarySearchTree::traverse = (process) ->
  inOrder = (node) ->
    if node
      if node.left?
        inOrder node.left
        
      process.call @, node
      
      if node.right?
        inOrder node.right
    
  inOrder @root

bt = new BinarySearchTree
bt.add(3)
bt.add(5)
bt.toString()
# alert bt.toString()