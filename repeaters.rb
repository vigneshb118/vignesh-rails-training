nums = gets.chomp.split.map(&:to_i)
seen = {}
repeater = -1
index = -1

nums.each_with_index do |num, i|
  if seen.key?(num)
    repeater = num
    index = i
    break
  else
    seen[num] = i
  end
end

p [repeater, index]
