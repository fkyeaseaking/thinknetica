print "Triangle first side: "
first_side = gets.chomp.to_f

print "Triangle second side: "
second_side = gets.chomp.to_f

print "Triangle third side: "
third_side = gets.chomp.to_f

sides_arr = [first_side, second_side, third_side]
max_side = sides_arr.max
sides_arr.delete_at(sides_arr.index(max_side))

return puts "Your triangle is invalid" if max_side >= sides_arr.sum
puts "Your triangle is isosceles" if first_side == second_side || second_side == third_side || first_side == third_side
return puts "Your triangle is equilateral" if first_side == second_side && second_side == third_side
return puts "Your triangle is right" if max_side**2 == sides_arr.first**2 + sides_arr.last**2
