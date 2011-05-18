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
      if value < current.value
        if current.left is null
          current.left = node
          break
        else
          current = current.left
      else if value > current.value
        if current.irght is null
          current.right = node
          break
        else
          current = current.right
      else
        break
    