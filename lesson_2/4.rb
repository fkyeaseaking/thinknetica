letters_arr = ("a".."z").to_a
vowels_arr = ["a", "e", "i", "o", "u"]
hash = {}

letters_arr.each_with_index do |letter, i|
  hash[letter] = i + 1 if vowels_arr.include?(letter)
end
