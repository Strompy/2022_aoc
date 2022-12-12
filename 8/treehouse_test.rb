require 'minitest/autorun'
require 'minitest/pride'
require_relative './treehouse'

class TreehouseTest < Minitest::Test
  def test_it_can_read_lines
    forest = Treehouse.new('test_input.txt')
    assert_equal 5, forest.grid.size
    assert_equal 5, forest.grid[0].size
    assert_equal 5, forest.grid[-1].size
  end
  
  def test_it_can_count_visible_trees
    forest = Treehouse.new('test_input.txt')
    assert_equal 21, forest.visible_tree_count
  end
  
  def test_it_can_count_visible_interior_trees
    forest = Treehouse.new('test_input.txt')
    assert_equal 5, forest.interior_visible_tree_count
  end
  
  def test_it_can_calc_tree_score
    forest = Treehouse.new('test_input.txt')
    assert_equal 4, forest.tree_score(5, 1, 2)
    assert_equal 8, forest.tree_score(5, 3, 2)
  end
  
  def test_it_can_find_highest_interior_tree_score
    forest = Treehouse.new('test_input.txt')
    assert_equal 8, forest.highest_interior_tree_score
  end
end

# Solve Part 1:
forest = Treehouse.new('input.txt')
puts "Part 1 Solution: #{forest.visible_tree_count}"

# Solve Part 2:
forest = Treehouse.new('input.txt')
puts "Part 2 Solution: #{forest.highest_interior_tree_score}"
