BinarySearchTree = () ->
  @_root = null

class BinarySearchTree

  add = (value) ->
    node = 
      value: value
      left: null
      right: null
    
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
          if current.right is null
            current.right = node
            break
          else
            current = current.right
        else
          break
    
    contains = (value) ->
      found = false
      current = @root
      
      while not found and current
        if value < current.value
          current = current.left
        else if value > current.value
          current = current.right
        else
          found = true
      
      found
    
    remove = (value) ->
      found = false
      parent = null
      current = @root
      
      while not found and current
        if value < current.value
          parent = current
          current = current.left
        else if value > current.value
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
              
              unless replacementParent is null
                replacementParent.right = replacement.left
                replacement.right = @root.right
                replacement.left = @root.left
              else
                replacement.right = @root.right
              
              @root = replacement
        else
          switch childCount
            when 0
              if current.value < parent.value
                parent.left = null
              else
                parent.right = null
              break
            when 1
              if current.value < parent.value
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
              
              if current.value < parent.value
                parent.left = replacement
              else
                parent.right = replacement
    
    size = () ->
      length = 0
      
      this.traverse((node) -> result.push node.value)
      result

    toArray = () ->
      result = []
      
      this.traverse((node) -> result.push node.value)
      result
    
    toString = () ->
      return this.toArray().toString()
    
    traverse = (process) ->
      inOrder = (node) ->
        if node
          if node.left isnt null
            inOrder node.left
          
          process.call this, node
        
          if node.right isnt null
            inOrder node.right
            
      inOrder @root
