days_in_month= [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
count = 0

print "Day: "
day = gets.chomp.to_i

print "Month: "
month = gets.chomp.to_i

print "Year: "
year = gets.chomp.to_i

days_in_month.each_with_index do |days, index|
  count += days if index < month - 1
end
count += day

count += 1 if ((year % 4 == 0 && !(year % 100 == 0)) || year % 400 == 0) && ((day == 29 && month == 2) || month > 2)

puts "Day counts: #{ count }"
