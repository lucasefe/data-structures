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

  def delete(value)
    @root_node = delete_node @root_node, Node.new(value, nil, nil)
  end

  def delete_node(tnode, node)
    if tnode.value == node.value
      tnode = remove(tnode)
    elsif node.value < tnode.value
      tnode.left = delete_node(tnode.left,node)
    else
      tnode.right = delete_node(tnode.right,node)
    end
    tnode
  end

  def remove(node)
    if node.left.nil? && node.right.nil?
      node = nil
    elsif !node.left.nil? && node.right.nil?
      node = node.left
    elsif node.left.nil? && !node.right.nil?
      node = node.right
    else
      node = replace_parent(node)
    end
    node
  end

  def replace_parent(node)
    node.value = min_node(node.right)
    node.right = update(node.right)
    node
  end

  def update(node)
    unless node.left.nil?
      node.left = update(node.left)
    end
    node.right
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
    search_dfs(value)
  end

  def search_iterative(value)
    node = search_node(value)
    return node.value unless node.nil?
  end

  def search_node(value)
    node = @root_node
    while !node.nil?
      return node if node.value == value
      if value < node.value
        node = node.left
      else
        node = node.right
      end
    end
  end

  # BFS / Breadth First Search
  def search_bfs(value)
    return false unless @root_node
    queue = Array.new
    queue.push(@root_node)

    while !queue.empty?
      node = queue.shift
      if node.value == value
        return value
      else
        queue.push(node.left) unless node.left.nil?
        queue.push(node.right) unless node.right.nil?
      end
    end
    return nil
  end

  def search_dfs(value)
    return false unless @root_node
    stack = []
    stack.push @root_node

    while !stack.empty?
      node = stack.pop
      return value if node.value == value
      stack.push(node.left) unless node.left.nil?
      stack.push(node.right) unless node.right.nil?
    end
  end

  def max_node(node = nil)
    node ||= @root_node
    return if node.nil?
    node = node.right while !node.right.nil?
    node
  end

  def max
    node = max_node
    return node.value unless node.nil?
  end

  def min_node(node = nil)
    node ||= @root_node
    return if node.nil?
    node = node.left while !node.left.nil?
    node
  end

  def min
    node = min_node
    return node.value unless node.nil?
  end

  def inspect
    "< Node value=#{value}, left=#{left.try(:value)} right=#{right.try(:value)} >"
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

tree.insert 59
tree.insert 58
tree.insert 57
tree.delete(58)

assert tree.search(23) == 23
assert tree.search(58).nil?
assert tree.search(35) == 35
assert tree.search(123456).nil?

assert tree.min == 23
assert tree.max == 60


# preorder: self, left, right
# inorder: left, self, right
# postorder: left, right, self
