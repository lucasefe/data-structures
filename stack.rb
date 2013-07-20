require 'test/unit'

class Node
  
  attr_accessor :next, :data
  
  def initialize(data)
    @data = data
  end

end

class Stack

  attr_accessor :top

  def pop
    return unless self.top
    current = self.top
    self.top = current.next
    current.data
  end

  def push(data)
    current = Node.new(data)
    current.next = self.top
    self.top = current
  end

end

include Test::Unit::Assertions

stack = Stack.new
stack.push(1)
stack.push(2)
assert stack.pop == 2
assert stack.pop == 1
assert stack.pop == nil

