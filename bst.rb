require 'test/unit'

include Test::Unit::Assertions

class FuckingBinaryTree

  Node = Struct.new(:value, :left, :right)

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

  def search(value)
    node = @root_node
    while !node.nil?
      return value if node.value == value
      if value < node.value
        node = node.left
      else
        node = node.right
      end
    end
  end

end


tree = FuckingBinaryTree.new
tree.insert 50
assert tree.root_node.value == 50

tree.insert 23
assert tree.root_node.left.value == 23
tree.insert 35
assert tree.root_node.left.value == 23
assert tree.root_node.left.right.value == 35
tree.insert 60
assert tree.root_node.right.value == 60

assert tree.search(23) == 23
assert tree.search(60) == 60
assert tree.search(50) == 50
assert tree.search(35) == 35
assert tree.search(123456).nil?

