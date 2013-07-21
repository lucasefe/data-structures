require 'test/unit'
include Test::Unit::Assertions


class FuckingBinaryTree

  Node = Struct.new(:value, :left, :right) do 
    def inspect
      left_value = left.value unless left.nil?
      right_value = right.value unless right.nil?
      "< Node value=#{value}, left=#{left_value} right=#{right_value} >"
    end
  end

  attr_accessor :root_node
    
  def insert(value)
    new_node = Node.new(value, nil, nil)
    @root_node = new_node and return if @root_node.nil?
    insert_into_node(@root_node, new_node)
  end

  def insert_into_node(node, new_node)
    return node if node.value == new_node.value

    if new_node.value < node.value
      if node.left.nil?
        node.left = new_node
      else
        insert_into_node(node.left, new_node)
      end
    elsif new_node.value > node.value
      if node.right.nil?
        node.right = new_node
      else
        insert_into_node(node.right, new_node)
      end
    end
  end

  def heapify
    nodes = []
    size = self.traverse {|n| nodes << n.dup }
    nodes.sort_by!(&:value)
    0.upto(size - 1) do |i|
      left = 2*i + 1
      right = left + 1
      nodes[i].left = size < left ? nil : nodes[left]
      nodes[i].right = size < right ? nil : nodes[right]
    end

    puts nodes.inspect
    FuckingBinaryTree.new.tap {|b| b.root_node = nodes[0] }
  end

  def traverse
    stack = [@root_node]
    count = 0
    while !stack.empty?
      count += 1
      node = stack.pop
      yield node if block_given?
      stack.push(node.right) unless node.right.nil?  
      stack.push(node.left) unless node.left.nil?  
    end
    count
  end

  def traverse_bfs
    queue = [@root_node]
    while !queue.empty?
      node = queue.shift
      yield node if block_given?
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
    end
  end

end

tree = FuckingBinaryTree.new

tree.insert 23
tree.insert 35
tree.insert 50
tree.insert 57
tree.insert 58
tree.insert 59
tree.insert 60
tree.insert 21
tree.insert 22
tree.insert 10
tree.insert 2
tree.insert 5
tree.insert 3
tree.insert 4
tree.insert 6

tree.heapify.traverse_bfs {|n| print n.value.to_s + "->" } 

