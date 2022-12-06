require 'minitest/autorun'
require 'minitest/pride'
require_relative './supply_stacks'

class SupplyStacksTest < Minitest::Test
  def test_it_can_read_lines
    supply = SupplyStacks.new('test_input.txt')
    assert_equal 3, supply.stacks.size
    assert_equal ['Z', 'N'], supply.stacks[0]
    assert_equal ['M', 'C', 'D'], supply.stacks[1]
    assert_equal ['P'], supply.stacks[2]
    assert_equal 4, supply.directions.size
  end
  
  def test_it_can_move_crate
    supply = SupplyStacks.new('test_input.txt')
    supply.move_crate(supply.directions[0])
    assert_equal ['Z', 'N', 'D'], supply.stacks[0]
    assert_equal ['M', 'C'], supply.stacks[1]
    assert_equal ['P'], supply.stacks[2]
    
    supply.move_crate(supply.directions[1])
    assert_equal [], supply.stacks[0]
    assert_equal ['M', 'C'], supply.stacks[1]
    assert_equal ['P', 'D', 'N', 'Z'], supply.stacks[2]
  end
  
  def test_it_can_execute_directions_and_return_message
    supply = SupplyStacks.new('test_input.txt')
    supply.execute_directions!
    assert_equal 'CMZ', supply.return_message
  end
end

# Solve Part 1: 
supply = SupplyStacks.new('input.txt')
supply.execute_directions!
puts "Part 1 Solution: #{supply.return_message}"