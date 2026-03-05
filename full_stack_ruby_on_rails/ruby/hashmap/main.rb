# frozen_string_literal: true

require_relative 'lib/hashmap'

test = HashMap.new

# Insert data in hash map
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts 'Length after inserting 12 items:'
puts test.length
puts

# Overwrite values (will not change length)
test.set('apple', 'green')
test.set('banana', 'gold')

puts 'Value of apple (should be green):'
puts test.get('apple')
puts

puts 'Value of banana (should be gold):'
puts test.get('banana')
puts

puts 'Length after overwriting:'
puts test.length
puts

# Trigger resizing
test.set('moon', 'silver')

puts 'Length after adding moon:'
puts test.length
puts

# Test other methods
puts 'Get carrot:'
puts test.get('carrot')
puts

puts 'Check if frog exists:'
puts test.has?('frog')
puts

puts 'Remove dog:'
puts test.remove('dog')
puts

puts 'Length after removing dog:'
puts test.length
puts

puts 'All keys:'
p test.keys
puts

puts 'All values:'
p test.values
puts

puts 'All entries:'
p test.entries
puts

# Clear hash map
test.clear

puts 'Length after clear:'
puts test.length
