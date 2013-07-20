require 'test/unit'

include Test::Unit::Assertions

class Node 
  
  attr_accessor :data, :next
  
  def initialize(data)
    @data = data
  end

end


class Queue

  attr_accessor :first, :last

  def enqueue(data)
    if first.nil?
      self.first = Node.new(data)
      self.last = self.first
    else
      self.last.next = Node.new(data)
      self.last = self.last.next
    end
  end

  def dequeue
    unless first.nil?
      self.last = nil if self.last == self.first
      data = first.data
      self.first = first.next
      data
    end
  end

end


queue = Queue.new
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)

assert queue.dequeue == 1
assert queue.dequeue == 2
assert queue.dequeue == 3
assert queue.dequeue.nil?
