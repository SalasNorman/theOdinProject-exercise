# frozen_string_literal: true

# A simple implementation of a HashMap data structure using array
# TODO: change array into linked_list
class HashMap
  attr_reader :capacity

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  # Hash function for string keys
  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  # Set key-value pair
  def set(key, value)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    # Update existing key
    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        break
      end
    end

    # Add new key-pair
    bucket << [key, value]
    @size += 1

    # Resize if load factor greater
    resize if (@size.to_f / @capacity) > @load_factor
  end

  # Get value by key
  def get(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    bucket.each { |pair| return pair[1] if pair[0] == key }
    nil
  end

  # Check if key exists
  def has?(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    bucket.any? { |pair| pair[0] == key }
  end

  # Remove key
  def remove(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    bucket.each_with_index do |pair, i|
      next unless pair[0] == key

      removed = bucket.delete_at(i)
      @size -= 1
      return removed[1]
    end
    nil
  end

  # Number of stored keys
  def length
    @size
  end

  # Clear hash map
  def clear
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  # Return all keys
  def keys
    @buckets.flat_map { |bucket| bucket.map { |pair| pair[0] } }
  end

  # Return all values
  def values
    @buckets.flat_map { |bucket| bucket.map { |pair| pair[1] } }
  end

  # Return key-value pairs
  def entries
    @buckets.flat_map { |bucket| bucket.map { |pair| pair } }
  end

  private

  # Resize buckets when load factor exceeded
  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    old_buckets.each do |bucket|
      bucket.each { |pair| set(pair[0], pair[1]) }
    end
  end
end
