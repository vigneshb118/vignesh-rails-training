require 'json'
arr = JSON.parse(gets.chomp)
k = gets.chomp.to_i
sum = 0

for i in 0..(arr.length - k) do
  array_sum = arr[i, k].sum
  sum = array_sum if array_sum > sum
end

p sum