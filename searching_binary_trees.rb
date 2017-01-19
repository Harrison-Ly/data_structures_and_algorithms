class Node
  attr_accessor :value, :parent, :left, :right
  def initialize(value = nil, parent = nil)
    @value = value
    @parent = parent
    @left = nil
    @right = nil
  end
end

class BinaryTree
  def initialize(root = nil)
    @root = Node.new(root)
  end

  def build_tree(array)
    @root = Node.new(array.shift)
    array.each do |i|
      add_node(i, @root)
    end
  end
  
  def add_node(value, node)
    if value < node.value
      if node.left == nil
        node.left = Node.new(value, node)
      else
        add_node(value, node.left)
      end
    elsif value > node.value
      if node.right == nil
        node.right = Node.new(value, node)
      else
        add_node(value, node.right)
      end
    end
  end
  
  def breadth_first_search(target)
    queue = [@root]
    until queue.empty?
      node = queue[0]
      return "#{node} is #{node.value}" if node.value == target
        queue << node.left if node.left != nil
        queue << node.right if node.right != nil
        queue.shift
    end
    nil
  end
  
  def depth_first_search(target)
    stack = [@root]
    until stack.empty?
      node = stack[-1]
      return "#{node} is #{node.value}" if node.value == target
      stack.pop
      stack << node.left if node.left != nil
      stack << node.right if node.right != nil
    end
    nil
  end
  
  def dfs_rec(target, node = @root)
    return "#{node} is #{node.value}" if node.value == target
    dfs_rec(target, node.left) if node.left != nil
    dfs_rec(target, node.right) if node.right != nil
  end
end


#test
a = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = BinaryTree.new
tree.build_tree(a)
puts tree.breadth_first_search(5)
puts tree.depth_first_search(67)
puts tree.dfs_rec(67)