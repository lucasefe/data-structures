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

  def height
    height_node(@root_node)
  end

  def height_node(node)
    return 0 if node.nil?
    left_height = height_node(node.left) 
    right_height = height_node(node.right)
    return 1 + (left_height > right_height ? left_height : right_height )
  end

  def rotate_left(old_root = nil)
    old_root ||= @root_node
    @root_node = old_root.right
    old_root.right = @root_node.left
    @root_node.left = old_root
  end

  def rotate_right(old_root = nil)
    old_root ||= @root_node
    @root_node = old_root.left
    old_root.left = @root_node.right
    @root_node.right = old_root
  end
end

tree = FuckingBinaryTree.new
1.upto(10) { |n| tree.insert n }

assert tree.height == 10
tree.rotate_left
tree.rotate_left
assert tree.height == 8
tree.rotate_right
assert tree.height == 9



