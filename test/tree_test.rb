require './lib/tree'
require './lib/node'
require 'minitest/autorun'


class TreeTest < MiniTest::Test
  def test_tree_has_a_name
    tree = Tree.new("binary dude")

    assert_equal "binary dude", tree.name
  end

  def test_tree_root_is_nil_default
    tree = Tree.new("aspen")

    assert_nil tree.root
  end

  def test_if_inserting_first_node_it_is_the_root_return_depth
    tree = Tree.new("maple")

    assert_equal 0, tree.insert(50, "Hello")
    assert_equal 50, tree.root.score
  end

  def test_insert_node_goes_to_right_if_score_bigger_return_depth
    tree = Tree.new("maple")
    tree.insert(50, "Hello")

    assert_equal 1, tree.insert(75, "Shrek")
    assert_equal 75, tree.root.right_child.score
  end

  def test_insert_node_goes_to_left_if_score_smaller_return_depth
    tree = Tree.new("maple")
    tree.insert(50, "Hello")

    assert_equal 1, tree.insert(32, "Gone Girl")
    assert_equal 32, tree.root.left_child.score
  end

  def test_insert_five_nodes_with_depth_of_three
    tree = Tree.new("maple")

    assert_equal 0, tree.insert(50, "Hello")
    assert_equal 1, tree.insert(75, "Gone Girl")
    assert_equal 2, tree.insert(70, "Rush Hour")
    assert_equal 2, tree.insert(86, "Shanghai Knights")
    assert_equal 3, tree.insert(55, "")

    assert_equal 75, tree.root.right_child.score
    assert_equal 70, tree.root.right_child.left_child.score
    assert_equal 86, tree.root.right_child.right_child.score
  end

  def test_does_tree_contain_a_score_include?
    tree = Tree.new("Oak")
    tree.insert(50, "Hello")
    tree.insert(75, "Gone Girl")
    tree.insert(70, "Rush Hour")
    tree.insert(86, "Shanghai Knights")

    assert tree.include?(50)
    assert tree.include?(86)
    refute tree.include?(3)
  end

  def test_depth_of_if_score_present_return_nodes_depth
    tree = Tree.new("Oak")
    tree.insert(50, "Hello")
    tree.insert(75, "Gone Girl")
    tree.insert(70, "Rush Hour")
    tree.insert(86, "Shanghai Knights")

    assert_equal 0, tree.depth_of(50)
    assert_equal 1, tree.depth_of(75)
    assert_equal 2, tree.depth_of(70)
    assert_equal 2, tree.depth_of(86)
    assert_nil tree.depth_of(3)
  end

  def test_max_find_highest_score_and_return_title_too
    tree = Tree.new("Oak")
    tree.insert(50, "Hello")
    tree.insert(75, "Gone Girl")
    tree.insert(70, "Rush Hour")
    tree.insert(86, "Shanghai Knights")

    maximum1 = {"Shanghai Knights" => 86}
    assert_equal maximum1, tree.max

    tree.insert(99, "")

    maximum2 = {"" => 99}
    assert_equal maximum2, tree.max
  end

  def test_min_find_lowest_score_and_return_title_too
    tree = Tree.new("Oak")
    tree.insert(50, "Hello")
    tree.insert(75, "Gone Girl")
    tree.insert(70, "Rush Hour")
    tree.insert(86, "Shanghai Knights")
    tree.insert(46,"")
    tree.insert(48,"")
    tree.insert(3, "Hello World")

    minimum1 = {"Hello World"=>3}
    assert_equal minimum1, tree.min
  end

  def test_sort_return_array_of_hashes_in_ascending_order
    tree = Tree.new("Pine")
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    result = [{"Bill & Ted's Bogus Journey"=>36},
              {"Charlie's Country"=>38},
              {"Armageddon"=>58},
              {"Collateral Damage"=>69},
              {"Charlie's Angels"=>86},
              {"Bill & Ted's Excellent Adventure"=>93},
              {"Animals United"=>98}]

    assert_equal result, tree.sort

    tree = Tree.new("Pine")
    tree.insert(46,"Up")
    tree.insert(48,"Shawshank Redemption")
    tree.insert(3, "Wonderwoman")
    tree.insert(10, "ten")
    tree.insert(5, "five")
    tree.insert(50, "Hello")
    tree.insert(75, "Gone Girl")
    tree.insert(70, "Rush Hour")
    tree.insert(86, "Shanghai Knights")

    result = [{"Wonderwoman"=>3},
            {"five"=>5},
            {"ten"=>10},
            {"Up"=>46},
            {"Shawshank Redemption"=>48},
            {"Hello"=>50},
            {"Rush Hour"=>70},
            {"Gone Girl"=>75},
            {"Shanghai Knights"=>86}]

    assert_equal result, tree.sort
  end

  def test_load_txt_file_return_number_nodes_inserted
    tree = Tree.new("Oak")
    tree.insert(50, "Hello")
    tree.insert(75, "Gone Girl")
    tree.insert(70, "Rush Hour")
    tree.insert(86, "Shanghai Knights")
    tree.insert(46,"Up")

    assert_equal 94, tree.load('./text_files/movies.txt')
  end

  def test_health_returns_nodes_at_certain_depth_with_number_of_children
    tree = Tree.new("Pine")
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 86]], tree.health(1)
    assert_equal [[36, 2, 29], [93, 3, 43]], tree.health(2)
  end

end
