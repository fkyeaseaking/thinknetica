arr = [0, 1]
index = 1
number = 0

loop do
  number = arr[index] + arr[index-1]
  break if number >= 100
  arr << number
  index += 1
end
