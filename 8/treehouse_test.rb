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
end

# Solve Part 1:
forest = Treehouse.new('input.txt')
puts "Part 1 Solution: #{forest.visible_tree_count}"
