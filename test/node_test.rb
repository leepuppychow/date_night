require './lib/node'
require 'minitest/autorun'
require 'minitest/pride'

class NodeTest < MiniTest::Test
  def test_node_has_a_score_and_title
    node = Node.new(50)

    assert_equal 50, node.score
    assert_equal "", node.title
  end

  def test_node_attributes
    node = Node.new(40, "Get Out")

    assert_equal "Get Out", node.title
    assert_equal 40, node.score
    assert_equal 0, node.depth
    assert_nil node.left_child
    assert_nil node.right_child
  end

  def test_attributes_are_valid_with_different_input
    node = Node.new(60, "Hello World")

    assert_equal "Hello World", node.title
    assert_equal 60, node.score
    assert_equal 0, node.depth
    assert_nil node.left_child
    assert_nil node.right_child
  end

end
