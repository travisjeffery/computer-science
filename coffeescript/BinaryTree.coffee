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
  
Node::getValue = () ->
  return @_data

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
  current = @_root
  
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
  current = @_root
  
  while not found and current
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
    
    if current is @_root
      switch childCount
        when 0
          @_root = null
          break
        when 1
          @_root = if current.right is null then current.left else current.right
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
      if node.left isnt null
        inOrder node.left
        
      process.call @, node
      
      if node.right isnt null
        inOrder node.right
    
  inOrder @_root

bt = new BinarySearchTree
bt.add(3)
alert bt.toString()