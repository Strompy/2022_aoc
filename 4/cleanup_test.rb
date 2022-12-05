require 'minitest/autorun'
require 'minitest/pride'
require_relative './cleanup'

class CleanupTest < Minitest::Test
  def test_it_can_read_lines
    c = Cleanup.new('test_input.txt')
    assert_equal 6, c.pairs.size
  end
  
  def test_it_can_check_fully_contained?
    c = Cleanup.new('test_input.txt')
    assert_equal true, c.fully_contained?(c.pairs[3])
    assert_equal true, c.fully_contained?(c.pairs[4])
    assert_equal false, c.fully_contained?(c.pairs[0])
    assert_equal false, c.fully_contained?(c.pairs[1])
    assert_equal false, c.fully_contained?(c.pairs[2])
    assert_equal false, c.fully_contained?(c.pairs[5])
  end
  
  def test_it_can_count_fully_contained_pairs
    c = Cleanup.new('test_input.txt')
    assert_equal 2, c.count_fully_contained_pairs
  end
  
  def test_it_can_check_overlap?
    c = Cleanup.new('test_input.txt')
    assert_equal false, c.overlap?(c.pairs[0])
    assert_equal false, c.overlap?(c.pairs[1])
    assert_equal true, c.overlap?(c.pairs[2])
    assert_equal true, c.overlap?(c.pairs[3])
    assert_equal true, c.overlap?(c.pairs[4])
    assert_equal true, c.overlap?(c.pairs[5])
  end
  
  def test_it_can_count_overlapping_pairs
    c = Cleanup.new('test_input.txt')
    assert_equal 4, c.count_overlapping_pairs
  end
end

# Solve Part 1:
result = Cleanup.new('input.txt').count_fully_contained_pairs
puts "Part 1 Solution: #{result}"

# Solve Part 2:
result = Cleanup.new('input.txt').count_overlapping_pairs
puts "Part 2 Solution: #{result}"

