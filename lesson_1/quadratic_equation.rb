puts "Enter coefficients"

print "a: "
a = gets.chomp.to_f

print "b: "
b = gets.chomp.to_f

print "c: "
c = gets.chomp.to_f

discriminant = b**2 - 4 * a * c
puts "Discriminant is #{ discriminant }"

if discriminant < 0
  puts "No roots"
elsif discriminant > 0
  first_root = (-b + Math.sqrt(b**2 - 4 * a * c))/(2 * a)
  second_root = (-b - Math.sqrt(b**2 - 4 * a * c))/(2 * a)
  puts "Roots: #{ first_root }, #{ second_root }"
else
  root = -(b/2 * a)
  puts "Root: #{ root }"
end
