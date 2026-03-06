# frozen_string_literal: true

require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(arr)
    arr = arr.uniq.sort
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  def include?(value, node = @root)
    return false if node.nil?
    return true if node.data == value

    if value < node.data
      include?(value, node.left)
    else
      include?(value, node.right)
    end
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)

    elsif value > node.data
      node.right = delete(value, node.right)

    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      successor = min_value(node.right)
      node.data = successor.data
      node.right = delete(successor.data, node.right)
    end

    node
  end

  def min_value(node)
    current = node
    current = current.left while current.left
    current
  end

  def level_order
    return enum_for(:level_order) unless block_given?

    queue = [@root]

    until queue.empty?
      node = queue.shift
      yield node.data

      queue << node.left if node.left
      queue << node.right if node.right
    end

    self
  end

  def inorder(node = @root, &block)
    return enum_for(:inorder) unless block_given?
    return if node.nil?

    inorder(node.left, &block)
    yield node.data
    inorder(node.right, &block)

    self
  end

  def preorder(node = @root, &block)
    return enum_for(:preorder) unless block_given?
    return if node.nil?

    yield node.data
    preorder(node.left, &block)
    preorder(node.right, &block)

    self
  end

  def postorder(node = @root, &block)
    return enum_for(:postorder) unless block_given?
    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)
    yield node.data

    self
  end

  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def height(value)
    node = find(value)
    return nil unless node

    height_node(node)
  end

  def height_node(node)
    return -1 if node.nil?

    left = height_node(node.left)
    right = height_node(node.right)

    [left, right].max + 1
  end

  def depth(value, node = @root, level = 0)
    return nil if node.nil?
    return level if node.data == value

    if value < node.data
      depth(value, node.left, level + 1)
    else
      depth(value, node.right, level + 1)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left = height_node(node.left)
    right = height_node(node.right)

    return false if (left - right).abs > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    arr = inorder.to_a
    @root = build_tree(arr)
  end

  private

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2

    Node.new(
      arr[mid],
      build_tree(arr[0...mid]),
      build_tree(arr[mid + 1..])
    )
  end
end
