class Node
  attr_reader :score,
              :title
  attr_accessor :left_child,
                :right_child,
                :depth

  def initialize(score = 0, title = "")
    @score = score
    @title = title
    @left_child = nil
    @right_child = nil
    @depth = 0
  end

end
