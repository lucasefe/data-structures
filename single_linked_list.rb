require 'test/unit'
include Test::Unit::Assertions

class List
  attr_accessor :head, :tail
  Node = Struct.new(:value, :next)

  def insert(value)
    new_node = Node.new(value, nil)
    if @head.nil?
      @tail = @head = new_node
    else
      @tail.next = new_node
      @tail = new_node
    end
  end

  def remove(value)
    if @head.value == value
      @head = @head.next
      return true
    end

    prev = @head
    node = @head.next
    while !node.nil?
      if node.value == value
        prev.next = node.next
        @tail = prev if prev.next.nil? 
        return true 
      end
      prev = node
      node = node.next
    end
    false
  end

  def remove2(value)
    @head = remove_rec(@head, value)
  end

  def remove_rec(node, value)
    return if node.nil?
    if node.value == value
      return node.next
    end
    node.next = remove_rec(node.next, value)
    node
  end

  def each
    return if @head.nil?
    node = @head
    while !node.nil?
      yield(node)
      node = node.next
    end
  end

  def find_mth(mth)
    node = @head
    i = 0
    
    # Advances position
    while i < mth
      return unless node.next
      node = node.next
      i += 1
    end
    mth_node = @head
    while node.next
      node = node.next
      mth_node = mth_node.next
    end
    mth_node
  end

  # O(n)
  def cycle?
    slow = self.head
    fast = self.head.next
    loop do 
      if fast.nil? || fast.next.nil?
        return false
      elsif fast == slow || fast.next == slow
        return true
      else
        slow = slow.next
        fast = fast.next.next
      end
    end
  end
end

list = List.new
1.upto(10) do |n|
  list.insert(n)
end

list.remove(1)
list.remove(5)
list.remove(6)
list.remove(10)
list.each do |node|
  puts node.value
end
assert !list.cycle?

assert list.head.value == 2
assert list.tail.value == 9
assert list.find_mth(1).value == 8
assert !list.cycle?


# Cycles

list = List.new
list.insert(1)
list.insert(2)
list.insert(3)
list.insert(4)
list.tail.next = list.head

assert list.cycle? 
