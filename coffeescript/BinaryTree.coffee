class Node
  @_left
  @_right
  @_data
  
  Node = (left, right, data) ->
    @_left = left
    @_right = right
    @_data = data
    
Node::getLeft = () ->
  return @_left

Node::getRight = () ->
  return @_right
  
Node::getData = () ->
  return @_data

Node::toString = () ->
  return @getValue().toString()

class BinarySearchTree
  
  BinarySearchTree = () ->
    @_root = null
    
BinarySearchTree::add = (data) ->
  node = new Node(null, null, data)
    
  if @_root is null
    @_root = node
  else
    current = @_root
    
    while true
      if data < current.getData()
        if current.getLeft() is null
          current.getLeft() = node
          break
        else
          current = current.getLeft()
      else if data > current.getData()
        if current.getRight() is null
          current.getRight() = node
          break
        else
          current = current.getRight()
      else
        break

BinarySearchTree::contains = (data) ->
  found = false
  current = @_root
  
  while not found and current
    if data < current.getData()
      current = current.getLeft()
    else if data > current.getData()
      current = current.getRight()
    else
      found = true
      
  found

BinarySearchTree::remove = (data) ->
  found = false
  parent = null
  current = @_root
  
  while not found and current?
    if data < current.getData()
      parent = current
      current = current.getLeft()
    else if data > current.getData()
      parent = current
      current = current.getRight()
    else
      found = true
  
  if found
    childCount = (if current.getLeft() isnt null then 1 else 0) + (if current.getRight() isnt null then 1 else 0)
    
    if current is @_root
      switch childCount
        when 0
          @_root = null
          break
        when 1
          @_root = if current.getRight() is null then current.getLeft() else current.getRight()
          break
        when 2
          replacement = @_root.left
          
          while replacement.right isnt null
            replacementParent = replacement
            replacement = replacement.right
          
          if replacementParent isnt null
            replacementParent.right = replacement.left
            replacement.right = @_root.right
            replacement.left = @_root.left
          else
            replacement.right = @_root.right
          
          @_root = replacement
          
    else
      switch childCount
        when 0
          if current.getData() < parent.data
            parent.left = null
          else
            parent.right = null
          break
        when 1
          if current.getData() < parent.data
            parent.left = if current.getLeft() is null then current.getRight() else current.getLeft()
          else
            parent.right = if current.getLeft() is null then current.getRight() else current.getLeft()
          break
        when 2
          replacement = current.getLeft()
          replacementParent = current
          
          while replacement.right isnt null
            replacementParent = replacement
            replacement = replacement.right
            
          replacementParent.right = replacement.left
          
          replacement.right = current.getRight()
          replacement.left = current.getLeft()
          if current.getData() < parent.data
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
    
  inOrder @_root

bt = new BinarySearchTree
bt.add(3)
alert bt.toString()