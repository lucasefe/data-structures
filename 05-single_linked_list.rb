require 'test/unit'
 
include Test::Unit::Assertions

class List

  class ListElement

    attr_reader :data
    attr_accessor :next

    def initialize(data = nil)
      @data = data
    end

  end
  
  attr_reader :size, :head, :tail

  def initialize
    @size = 0
    @head = nil
  end

  def insert(data, element = nil)
    new_element = ListElement.new(data)
    unless element
      @tail = new_element if size.zero?
      new_element.next = @head
      @head = new_element
    else
      if element.next.nil?
        element.next = new_element
        @tail = new_element
      else
        new_element.next = element.next
        element.next = new_element
      end
    end
    @size += 1
    new_element
  end

  def remove(element = nil)
    return nil if size.zero?
    if element.nil?
      old_element = @head
      @head = @head.next
      @tail = nil if size == 1
    else
      return nil if element.next.nil?
      old_element = element.next
      element.next = element.next.next
      @tail = element if element.next.nil?
    end
    @size -= 1
    old_element.data
  end

end

list = List.new
assert list.size == 0

one = list.insert "1"
assert list.size == 1
assert list.head.data == "1"
assert list.tail.data == "1"

two = list.insert "2", one
assert list.size == 2
assert list.head.data == "1"
assert list.tail.data == "2"

half = list.insert "0.5", one
assert list.size == 3
assert list.head.data == "1"
assert list.head.next.data == "0.5"
assert list.tail.data == "2"

list.remove
assert list.size == 2
assert list.head.data == "0.5"
assert list.tail.data == "2"

list.remove half
assert list.size == 1
assert list.head.data == "0.5"
assert list.tail.data == "0.5"


list = List.new
assert list.size == 0
one = list.insert "1"
two = list.insert "2"
assert list.head == two


