puts "Enter product, count and price. Enter 'stop' in product input when you end"

basket = {}
sum = 0

loop do
  print "Product: "
  product = gets.chomp
  break if product.downcase == "stop"

  print "Count: "
  count = gets.chomp.to_i

  print "Price: "
  price = gets.chomp.to_f
  
  product_sum = (count * price).floor(2)
  basket[product] = { count: count, price: price, sum: product_sum }
  sum += product_sum
end

puts basket
puts "Total: #{sum.floor(2)}$"
