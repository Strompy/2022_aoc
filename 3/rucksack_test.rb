require 'minitest/autorun'
require 'minitest/pride'
require_relative './rucksack'

class RucksackTest < Minitest::Test
  def test_it_can_read_lines
    ruck = Rucksack.new('test_input.txt')
    assert_equal 6, ruck.sacks.size
  end
  
  def test_it_can_find_shared_item
    ruck = Rucksack.new('test_input.txt')
    assert_equal 'p', ruck.find_shared_item(ruck.sacks[0])
    assert_equal 'L', ruck.find_shared_item(ruck.sacks[1])
    assert_equal 'P', ruck.find_shared_item(ruck.sacks[2])
    assert_equal 'v', ruck.find_shared_item(ruck.sacks[3])
    assert_equal 't', ruck.find_shared_item(ruck.sacks[4])
    assert_equal 's', ruck.find_shared_item(ruck.sacks[5])
  end
  
  def test_it_can_find_priority
    ruck = Rucksack.new('test_input.txt')
    assert_equal 16, ruck.find_priority('p')
    assert_equal 38, ruck.find_priority('L')
    assert_equal 42, ruck.find_priority('P')
    assert_equal 22, ruck.find_priority('v')
    assert_equal 20, ruck.find_priority('t')
    assert_equal 19, ruck.find_priority('s')
  end
  
  def test_it_can_sum_priorities
    ruck = Rucksack.new('test_input.txt')
    assert_equal 157, ruck.sum_priorities
  end
  
  def test_it_can_find_badge
    ruck = Rucksack.new('test_input.txt')
    assert_equal 'r', ruck.find_badge(ruck.sacks[0..2])
    assert_equal 'Z', ruck.find_badge(ruck.sacks[3..5])
  end
  
  def test_it_can_sum_badge_priorities
    ruck = Rucksack.new('test_input.txt')
    assert_equal 70, ruck.sum_badge_priorities
  end
end

# Solve Part 1:
ruck = Rucksack.new('input.txt')
puts "Part 1: #{ruck.sum_priorities}"

# Solve Part 2:
ruck = Rucksack.new('input.txt')
puts "Part 2: #{ruck.sum_badge_priorities}"
