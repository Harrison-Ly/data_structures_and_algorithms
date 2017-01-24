class BoardNode
  attr_accessor :parent, :children
  attr_reader :location
  
  def initialize(location)
    @location = location
    @parent = nil
    @children = []
  end
end


class Board
  #fixed variable
  KNIGHT_MOVES = [[-2, 1], [-2, -1], [-2, 2], [-1, -2], [1, -2], [1, 2], [2, 1], [2, -1]]
  
  attr_reader :root, :visited
  
  def initialize(root)
    @root = BoardNode.new(root)
    @visited = []
  end
  
  def all_moves(location)
    locations = []
    KNIGHT_MOVES.each do |move|
      new_move = [location[0] + move[0], location[1] + move[1]]
      #list all possible locations within the board
      unless (new_move[0] < 0 || new_move[0] < 0) || (new_move[1] > 8 || new_move[1] > 8)
        locations << new_move
      end
    end
    locations
  end
  
  def build_to(target)
    queue = [@root]
    current = @root
    
    until current.location == target
      current = queue.shift
      @visited << current.location
      locations = all_moves(current.location)
      
      locations.each do |location|
        unless @visited.include?(location)
          node = BoardNode.new(location)
          current.children << node
          node.parent = current
          queue << node
        end
      end
    end
    current
  end
end

def knight_moves(start, target)
  board = Board.new(start)
  target_node = board.build_to(target)
  current = target_node
  path = []
  until current.nil?
    path.unshift(current.location)
    current = current.parent
  end
  puts "You made it in #{path.length-1} moves! Here's your path:"
  unless path.empty?
    path.each { |i| puts i.to_s }
  end
end

knight_moves([3,3],[4,3])