def compress(s1)
  return "" if s1.empty?

  res = []
  i = 0
  while i < s1.length
    count = 1
    j = i + count
    while j < s1.length && s1[i] == s1[j]
      count += 1
      j += 1
    end
    res << "#{s1[i]}#{count}"
    i += count
  end
  res.join
end

def decompress(s1)
  res = ""
  i = 0
  while i < s1.length
    char = s1[i]
    i += 1
    num_str = ""
    while i < s1.length && s1[i] =~ /\d/
      num_str << s1[i]
      i += 1
    end

    count = num_str.to_i
    res << char * count
  end
  res
end


s1 = gets.chomp
action = gets.chomp
p send(:"#{action}", s1)