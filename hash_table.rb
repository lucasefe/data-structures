require 'test/unit'
include Test::Unit::Assertions

class HashTable
  
  attr_accessor :head, :tail

  class Node
    attr_accessor :prev, :next, :value, :key
    def initialize(attrs = {})
      @prev  = attrs[:prev]
      @key   = attrs[:key]
      @value = attrs[:value]
      @next  = attrs[:next]
    end
  end

  def initialize(options = {})
    @max_size = options.fetch(:max_size, 5)
    @head = @tail = nil
    @data = {}
  end

  def set(key, value)
    node = @data[key] 
    if node
      move_to_head(node)
    else
      node = add_to_head(key, value)
      @data[key] = node
      pop_tail
    end
    node.value
  end

  def get(key)
    node = @data[key]
    if node
      move_to_head(node)
      node.value
    end
  end

  def size
    @data.size
  end

  def each
    node = @head
    while !node.nil?
      yield [node.key, node.value]
      node = node.next
    end
  end

  private

  def move_to_head(node)
    return if @head == node
    prev = node.prev
    nex = node.next

    prev.next = nex
    if nex.nil?
      @tail = prev
      @tail.next = nil
    else
      nex.prev = prev
    end

    old_head = @head
    @head = node
    node.prev = nil
    node.next = old_head
  end

  def add_to_head(key, value)
    if @head
      old_head = @head
      @head = Node.new(key: key, value: value, next: old_head)
      old_head.prev = @head
      pop_tail
    else
      @tail = @head = Node.new(key: key, value: value)
    end
    @head
  end

  def pop_tail
    if @data.length > @max_size
      @data.delete(@tail.key)
      @tail = @tail.prev
      @tail.next = nil
    end
  end
end


hash = HashTable.new(max_size: 5)
hash.set('hola', 'dato')

assert_equal hash.head.value, 'dato'
assert_equal hash.head.key,   'hola'
assert_equal hash.tail.value, 'dato'
assert_equal hash.head, hash.tail
assert_equal hash.get('hola'), 'dato'
assert_equal hash.size, 1

hash = HashTable.new(max_size: 5)

1.upto(6) do |n|
  assert_equal n, hash.set(n.to_s, n) 
  assert_equal hash.head.value, n
  assert_equal hash.head.key,   n.to_s
end

hash.get('3')
assert_equal hash.head.value, 3
assert_equal hash.head.key,  '3'

hash.each do |k, v|
  puts "K: #{k} V: #{v}"
end

assert_equal hash.size, 5
