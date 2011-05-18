binarySearch = (items, values) ->
  
  startIndex = 0
  stopIndex = items.length - 1
  middle = Math.floor((stopIndex + startIndex)/2)
  
  while items[middle] isnt value and startIndex < stopIndex
    if value < items[middle]
      stopIndex = middle - 1
    else if value > items[middle]
      startIndex = middle + 1
    
    middle = Middle.floor((stopIndex + startIndex)/2)
  
  (items[middle] isnt value) ? -1 : middle
    

