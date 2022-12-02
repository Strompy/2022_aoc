require 'minitest/autorun'
require 'minitest/pride'
require_relative './rock_paper_scissors'

class RockPaperScissorsTest < MiniTest::Test
  def test_it_can_read_lines
    rps = RockPaperScissors.new('test_input.txt')
    assert_equal 3, rps.rounds.size
  end
  
  def test_it_can_play_round_and_return_score
    rps = RockPaperScissors.new('test_input.txt')
    assert_equal 8, rps.play_round
    assert_equal 1, rps.play_round
    assert_equal 6, rps.play_round
  end
  
  def test_it_can_calculate_total_score
    rps = RockPaperScissors.new('test_input.txt')
    rps.play_round
    assert_equal 8, rps.total_score
    rps.play_round
    assert_equal 9, rps.total_score
    rps.play_round
    assert_equal 15, rps.total_score
  end
  
  def test_it_can_find_winner
    rps = RockPaperScissors.new('test_input.txt')
    assert_equal 'draw', rps.find_winner('C', 'Z')
    assert_equal 'win', rps.find_winner('A', 'Y')
    assert_equal 'lose', rps.find_winner('B', 'X')
  end
  
  def test_it_can_run_tourney
    rps = RockPaperScissors.new('test_input.txt')
    assert_equal 15, rps.run_tourney
  end
end

rps = RockPaperScissors.new('input.txt')
puts "Part 1 Solution: "
puts rps.run_tourney