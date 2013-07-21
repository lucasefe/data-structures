require 'test/unit'
include Test::Unit::Assertions

class FuckingBinaryTree

  Node = Struct.new(:value, :left, :right) do 
    def inspect
      "< Node value=#{value}, left=#{left.try(:value)} right=#{right.try(:value)} >"
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

  def heigth
    heigth_node(@root_node)
  end

  # O(n)
  def heigth_node(node)
    return 0 if node.nil?
    left_height = heigth_node(node.left)
    right_height = heigth_node(node.right)
    return 1 + (left_height > right_height ? left_height : right_height)
  end

  # O(n)
  def preorder_traversal # no recursion
    stack = Array.new
    stack.push(@root_node)
    out = []
    while(!stack.empty?)
      node = stack.pop
      out << node.value
      stack.push(node.right) unless node.right.nil?
      # left goes last, because it wants to be popped firt
      stack.push(node.left) unless node.left.nil?
    end
    out

  end
  
  # O(log n)
  def nearest(bottom, top)
    node = @root_node
    while !node.nil?
      if bottom > node.value && top > node.value
        node = node.right
      elsif bottom < node.value && top < node.value
        node = node.left
      else
        return node.value
      end
    end
    return nil
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

assert_equal tree.heigth, 7

tree = FuckingBinaryTree.new
tree.insert 5
tree.insert 3
tree.insert 4
tree.insert 2
tree.insert 6

expected = [5, 3, 2, 4, 6] 
assert_equal expected, tree.preorder_traversal

tree.insert 1

#        5 
#     3     6
#   2    4
# 1

assert_equal 3, tree.nearest(1, 4)
