
class Node

  attr_accessor :next, :data

  def initialize(data)
    @data = data
  end

  def append(data)
    current_node = self
    while !current_node.next.nil? do
      current_node = current_node.next
    end
    current_node.next = Node.new(data)
  end

  def delete(data)
    n = self
    return self.next if n.data == data 

    while !n.next.nil? do 
      if n.next.data == data
        n.next = n.next.next
        return self 
      end
      n = n.next
    end
  end

  def each
    n = self
    while !n.nil? do 
      yield n
      n = n.next
    end
  end

end

list = Node.new(1)
list.append(2)
list.append(3)
list.each do |node|
  puts node.data
end


list.delete(2)
list.each do |node|
  puts node.data
end
