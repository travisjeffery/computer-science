def levenshtein_distance(string_1, string_2)
  return string_2.length if string_1.empty?
  return string_1.length if string_2.empty?

  [].tap do |result|
    operations_required =  string_1.first.eql?(string_2.first) ? 0 : 1
    result << operations_required + levenshtein_distance(string_1[1..-1], string_2[1..-1])
    result << 1 + levenshtein_distance(string_1[1..-1], string_2)
    result << 1 + levenshtein_distance(string_1, string_2[1..-1])
  end.min
end
