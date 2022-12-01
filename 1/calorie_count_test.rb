require 'minitest/autorun'
require 'minitest/pride'
require_relative './calorie_count'

class CalorieCountTest < Minitest::Test
  def test_it_can_read_lines
    counter = CalorieCount.new('test_input.txt')
    assert_equal 5, counter.elves.size
  end
  
  def test_it_can_find_most_calories
    counter = CalorieCount.new('test_input.txt')
    assert_equal 24000, counter.find_most_calories
  end
end
