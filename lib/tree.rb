class Tree
  attr_reader   :name,
                :root,
                :current_node,
                :sorted_scores

  def initialize(name)
    @name = name
    @root = nil
    @current_node = nil
    @sorted_scores = []
    @nodes_at_this_depth = []
    @total_nodes = 0
    @children_count = 0
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
      fill_tree(new_node, current_node.right_child)
    elsif new_node.score < current_node.score
      fill_tree(new_node, current_node.left_child)
    end
  end

  def include?(score, current_node = @root)
    if current_node.nil?
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
      include?(score, current_node.right_child)
    else
      include?(score, current_node.left_child)
    end
  end

  def depth_of(score)
    include?(score) ? @current_node.depth : nil
  end

  def max(current_node = @root)
    if current_node.right_child != nil
      max(current_node.right_child)
    else
      return convert_node_to_hash(current_node)
    end
  end

  def min(current_node = @root)
    if current_node.left_child != nil
      min(current_node.left_child)
    else
      return convert_node_to_hash(current_node)
    end
  end

  def convert_node_to_hash(node)
    {node.title => node.score}
  end

  def sort(current_node = @root)
    if !current_node.left_child.nil?
      sort(current_node.left_child)
    end
    @sorted_scores << convert_node_to_hash(current_node)
    if !current_node.right_child.nil?
      sort(current_node.right_child)
    end
    return @sorted_scores
  end

  def load(filename)
    file = split_up_comma_separated_file(filename)
    return insert_file_movies_into_tree(file)
  end

  def split_up_comma_separated_file(filename)
    file = File.readlines(filename).map do |line|
      line.split(",")
    end
  end

  def insert_file_movies_into_tree(file)
    movies_entered = 0
    file.each do |movie|
      if include?(movie.first.to_i) == false
        insert(movie.first.to_i, movie.last.strip)
        movies_entered += 1
      end
    end
    return movies_entered
  end

  def health(depth)
    @nodes_at_this_depth = []
    @total_nodes = 0

    health_algorithm(depth)
    @nodes_at_this_depth.map! do |node|
      node << (node.last.to_f / @total_nodes.to_f * 100).round
    end
  end

  def health_algorithm(depth, current_node=@root)
    if current_node.left_child != nil
      health_algorithm(depth, current_node.left_child)
    end

    @total_nodes += 1

    if current_node.depth == depth
      @children_count = 0
      number_of_children = find_number_of_children(current_node)
      @nodes_at_this_depth << [current_node.score, number_of_children]
    end

    if current_node.right_child != nil
     health_algorithm(depth, current_node.right_child)
    end
  end

  def find_number_of_children(current_node)
    if current_node.left_child != nil
      find_number_of_children(current_node.left_child)
    end
    @children_count += 1
    if current_node.right_child != nil
      find_number_of_children(current_node.right_child)
    end
    return @children_count
  end

end
