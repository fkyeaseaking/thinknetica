print "Your name: "
name = gets.chomp

print "Your height: "
height = gets.chomp.to_i

perfect_weight = (height - 110) * 1.15

if perfect_weight < 0
  puts "Your weight is optimal already"
else
  puts "#{ name.capitalize }, your pefect weight is #{ perfect_weight }"
end
