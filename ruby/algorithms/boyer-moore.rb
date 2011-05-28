ALPHABET_SIZE = 256

def compute_prefix(str, result=[])
  result[0] = 0
  
  k = 0
  for q in (1..str.length)
    while k > 0 && str[k] != str[q]
      k = result[k-1]
    end
    
    if str[k] == str[q]
      k += 1
    end
    
    result[q] = k
  end
end

def prepare_badcharacter_heuristic(str, result=[])
  for i in (0..ALPHABET_SIZE)
    result[i] = -1
  end

  str.length.times do |i|
    result[str[i]] = i
  end
end

compute_prefix("hello")
