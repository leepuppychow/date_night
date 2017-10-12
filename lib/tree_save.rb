require 'pry'

class Tree
  attr_reader   :name,
                :root
  attr_accessor :current_node,
                :parent_node,
                :sorted_scores

  def initialize(name)
    @name = name
    @root = nil
    @current_node = nil
    @parent_node = nil
    @sorted_scores = []
  end

  def insert(score, title)
    new_node = Node.new(score, title)
    if @root == nil
      set_root(new_node)
    else
      fill_tree(new_node)
    end
    return new_node.depth
  end

  def set_root(new_node)
    @root = new_node
    @root.depth = 0
  end

  def fill_tree(new_node, current_node = @root)
    new_node.depth += 1
    if new_node.score > current_node.score && current_node.right_child.nil?
      current_node.right_child = new_node
    elsif new_node.score < current_node.score && current_node.left_child.nil?
      current_node.left_child = new_node
    elsif new_node.score > current_node.score
      current_node = current_node.right_child
      fill_tree(new_node, current_node)
    elsif new_node.score < current_node.score
      current_node = current_node.left_child
      fill_tree(new_node, current_node)
    end
  end

  def include?(score, current_node = @root)
    if current_node.nil? #this means we reached bottom of tree with no matches
      return false
    elsif score == current_node.score
      @current_node = current_node
      return true
    else
      check_for_match_down_tree(score, current_node)
    end
  end

  def check_for_match_down_tree(score, current_node)
    if score > current_node.score
      current_node = current_node.right_child
      include?(score, current_node)
    else #score < current_node.score
      current_node = current_node.left_child
      include?(score, current_node)
    end
  end

  def depth_of(score)
    include?(score) ? @current_node.depth : nil
  end

  def convert_node_to_hash(node)
    node_as_hash = {node.title => node.score}
  end

  def max(current_node = @root)
    #done recursively
    # if current_node.right_child.nil?
    #   return current_node.score
    # else
    #   max(current_node.right_child)
    # end

    # #this is done iteratively (doesn't add more to stack)
    while !current_node.right_child.nil?
      current_node = current_node.right_child
    end
    return convert_node_to_hash(current_node)
  end

  def min(current_node = @root)
    convert_node_to_hash(check_left_branch(current_node))
    # while !current_node.left_child.nil?
    #   @parent_node = current_node
    #   current_node = current_node.left_child
    # end
    # return convert_node_to_hash(current_node)
  end

  def check_left_branch(current_node = @root)
    if current_node.left_child.nil? == false
      check_left_branch(current_node.left_child)
      #now we have reached the minimum (left-most)
    else
      return current_node
    end
  end

  def check_right_branch(current_node = @root)
    if current_node.right_child.nil? == false
      check_right_branch(current_node.right_child)
    else
      return current_node
    end
  end

  def sort(current_node = @root)

      def sort(current_node = @root)
        if !current_node.left_child.nil?
          # current_node = current_node.left_child
          #why does this line make it fail??
          sort(current_node.left_child)
        end

        @sorted_scores << convert_node_to_hash(current_node)

        if !current_node.right_child.nil?
          # current_node = current_node.right_child
          sort(current_node.right_child)
        else
          return
        end
        return @sorted_scores
      end
  end

end
