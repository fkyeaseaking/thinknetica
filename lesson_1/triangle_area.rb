print "Triangle base: "
base = gets.chomp.to_i

print "Triangle height: "
height = gets.chomp.to_i

return puts "Your data is invalid" if base <= 0 || height <= 0

area = base * height * 0.5

puts "Your triangle area is #{ area }"
