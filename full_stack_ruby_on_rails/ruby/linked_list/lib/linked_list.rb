require_relative 'node'

class LinkedList
  attr_accessor :head, :count

  def initialize
    @head = nil
    @count = 0
  end

  # Add to end of list
  def append(value)
    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
    else
      current = @head
      current = current.next_node while current.next_node
      current.next_node = new_node
    end
  end

  # Add to beginning
  def prepend(value)
    new_node = Node.new(value)
    new_node.next_node = @head
    @head = new_node
  end

  def size
    current = @head
    count = 0

    while current
      count += 1
      current = current.next_node
    end

    count
  end

  def head
    return nil if @head.nil?

    @head&.value
  end

  def tail
    tail = @head
    tail = tail.next_node until tail.next_node.nil?
    tail&.value
  end

  def at(index)
    current = @head
    index.times do
      current = current.next_node
    end

    return nil if current.nil?

    current&.value
  end

  def pop
    return nil if @head.nil?

    old_head = @head
    @head = @head.next_node

    old_head
  end

  def contains?(value)
    current = @head
    until current.value == value
      current = current.next_node
      return false if current.nil?
    end

    true
  end

  def index(value)
    current = @head
    index = 0

    while current
      return index if current.value == value

      current = current.next_node
      index += 1
    end

    nil
  end

  # Print list
  def to_s
    current = @head
    result = ''

    while current
      result += "( #{current.value} ) -> "
      current = current.next_node
    end
    result + 'nil'
  end
end
