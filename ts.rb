class Node 
  attr_accessor :value, :left, :right, :cost
  def to_s; value; end
  def cost; @cost == nil ? 0 : @cost; end
end
 
def ts(strategy, current, final, total_cost=0.0)
  return false if current.nil?
  return true  if current.value == final
  
  strategy.add_to_frontier(current.right) if not current.right.nil?
  strategy.add_to_frontier(current.left)  if not current.left.nil?
  
  node = strategy.choice(total_cost)
  cost = node == nil ? 0 : strategy.cost_of(node)
  ts(strategy, node, final, cost + total_cost)
end
 
#        a(0)
#      /     \
#     b(3)    c(2)
#    /   \     |
#   d(2) e(1)  d(4)
n1 = Node.new
n1.value = :a
n1.left  = Node.new
n1.right = Node.new
n1.left.value = :b
n1.left.cost  = 3
n1.right.value = :c
n1.right.cost = 2
 
n1.right.left = Node.new # from :c
n1.right.left.value = :d
n1.right.left.cost = 2
 
n1.left.left = Node.new # from :b
n1.left.left.value = :d
n1.left.left.cost  = 2
 
n1.left.right = Node.new
n1.left.right.value = :e
n1.left.right.cost = 1
 
# Depth-first
class StackStrategy < Array
  def cost_of(node); node.cost; end
  def choice(total_cost=0); pop; end
  def add_to_frontier(node); push(node); end
end
 
# Breadth-first
class QueueStrategy < Array
  def cost_of(node); node.cost; end
  def choice(total_cost=0); shift; end
  def add_to_frontier(node); push(node); end
end
 
# Best-first
class BestFirstStrategy < Array
  def cost_of(node); node.cost; end
  def choice(total_cost=0) 
    node = min_by{ |n| total_cost + cost_of(n) }; 
    delete_if{ |n| n.value == node.value }
    node
  end
  def add_to_frontier(node); push(node); end
end
 
class StrategyLoggable
  def initialize(strategy); 
    @strategy, @path = strategy, []
  end
  def cost_of(node); @strategy.cost_of(node); end
  def add_to_frontier(object); @strategy.add_to_frontier(object); end
  def choice(total_cost=0)
    ret = @strategy.choice(total_cost)
    @path.push(ret.value) unless ret.nil?
    ret
  end
  def final_path; @path; end
end
 
strategy = StrategyLoggable.new(StackStrategy.new)
puts "DFS> Found? #{ts(strategy, n1, :e)} -> #{strategy.final_path}" 
 
strategy = StrategyLoggable.new(StackStrategy.new)
puts "DFS> Found? #{ts(strategy, n1, :g)} -> #{strategy.final_path}" 
 
strategy = StrategyLoggable.new(QueueStrategy.new)
puts "BFS> Found? #{ts(strategy, n1, :e)} -> #{strategy.final_path}" 
 
strategy = StrategyLoggable.new(QueueStrategy.new)
puts "BFS> Found? #{ts(strategy, n1, :g)} -> #{strategy.final_path}"
 
strategy = StrategyLoggable.new(BestFirstStrategy.new)
puts "BestFirstS> Found? #{ts(strategy, n1, :d)} -> #{strategy.final_path}"
 
