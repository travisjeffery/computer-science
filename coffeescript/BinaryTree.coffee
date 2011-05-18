class Node
  @_left
  @_right
  @_value
  
  Node = (left, right, value) ->
    @_left = left
    @_right = right
    @_value = value
    
Node::getLeft = () ->
  return @_left

Node::getRight = () ->
  return @_right
  
Node::getValue = () ->
  return @_value

class BinarySearchTree
  
  BinarySearchTree = () ->
    @_root = null
    
BinarySearchTree::add = (value) ->
  node = new Node(null, null, value)
    
  if @_root is null
    @_root = node
  
