require 'test/unit'

include Test::Unit::Assertions

class Stack

  attr_accessor :head

  Node = Struct.new(:value, :next)

  def push(value)
    node = Node.new(value, nil)
    node.next = self.head
    self.head = node
  end

  def pop
    return if self.head.nil?
    node = self.head
    self.head = self.head.next
    node.value
  end
end

stack = Stack.new
1.upto(4) { |n| stack.push(n) }

assert stack.pop == 4
stack.push 10
assert stack.pop == 10
assert stack.pop == 3
assert stack.pop == 2
assert stack.pop == 1
assert stack.pop.nil?

