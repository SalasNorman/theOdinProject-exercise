# Simple bst code
# def build_tree(arr)
#   return nil if arr.empty?
#   mid = arr.length / 2
#   [arr[mid], build_tree(arr[0...mid]), build_tree(arr[mid+1..])]
# end
# p build_tree([1,4,6,7,9,10,14])

# frozen_string_literal: true
require_relative 'lib/tree'
# DRIVER SCRIPT

tree = Tree.new(Array.new(15) { rand(1..100) })

puts 'Initial tree:'
tree.pretty_print

puts "Balanced? #{tree.balanced?}"

puts 'Level order:'
tree.level_order { |n| print "#{n} " }
puts

puts 'Preorder:'
tree.preorder { |n| print "#{n} " }
puts

puts 'Postorder:'
tree.postorder { |n| print "#{n} " }
puts

puts 'Inorder:'
tree.inorder { |n| print "#{n} " }
puts

# Unbalance tree
tree.insert(150)
tree.insert(200)
tree.insert(250)
tree.insert(300)

puts "\nAfter inserting large numbers:"
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

# Rebalance
tree.rebalance

puts "\nAfter rebalancing:"
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

puts 'Level order:'
tree.level_order { |n| print "#{n} " }
puts

puts 'Preorder:'
tree.preorder { |n| print "#{n} " }
puts

puts 'Postorder:'
tree.postorder { |n| print "#{n} " }
puts

puts 'Inorder:'
tree.inorder { |n| print "#{n} " }
puts
