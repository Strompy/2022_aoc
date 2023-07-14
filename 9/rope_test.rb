require 'minitest/autorun'
require 'minitest/pride'
require_relative './rope'

class RopeTest < Minitest::Test
  def test_it_can_read_lines
    rope = Rope.new('test_input.txt')
    assert_equal 8, rope.moves.size
    assert_equal [0, 0], rope.head
    assert_equal [0, 0], rope.tail
  end
  
  def test_it_can_move_rope
    rope = Rope.new('test_input.txt')
    rope.move_rope(rope.moves.first)
    assert_equal [0, 4], rope.head
    assert_equal [0, 3], rope.tail
    
    rope.move_rope(rope.moves[1])
    assert_equal [-4, 4], rope.head
    assert_equal [-3, 4], rope.tail
  end
  
  def test_it_can_track_tail_positions
    rope = Rope.new('test_input.txt')
    rope.run_all_moves
    assert_equal 13, rope.tail_positions.size
  end
end

# Solve Part 1:
rope = Rope.new('input.txt')
rope.run_all_moves
puts "Part 1 Solution: #{rope.tail_positions.size}"