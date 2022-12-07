require 'minitest/autorun'
require 'minitest/pride'
require_relative './tuning'

class TuningTest < Minitest::Test
  def test_it_can_read_lines
    tuner = Tuning.new('test_input.txt')
    assert tuner.stream
    
    tuner2 = Tuning.new(nil, 'bvwbjplbgvbhsrlpgdmjqwftvncz')
    assert tuner2.stream
  end
  
  def test_it_can_find_start_of_stream
    tuner = Tuning.new('test_input.txt')
    assert_equal 7, tuner.find_start_of_stream
    
    tuner2 = Tuning.new(nil, 'bvwbjplbgvbhsrlpgdmjqwftvncz')
    assert_equal 5, tuner2.find_start_of_stream
    
    tuner3 = Tuning.new(nil, 'nppdvjthqldpwncqszvftbrmjlhg')
    assert_equal 6, tuner3.find_start_of_stream
    
    tuner4 = Tuning.new(nil, 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg')
    assert_equal 10, tuner4.find_start_of_stream
    
    tuner5 = Tuning.new(nil, 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw')
    assert_equal 11, tuner5.find_start_of_stream
  end
  
  def test_it_can_find_start_of_message
    tuner = Tuning.new('test_input.txt')
    assert_equal 19, tuner.find_start_of_message
    
    tuner2 = Tuning.new(nil, 'bvwbjplbgvbhsrlpgdmjqwftvncz')
    assert_equal 23, tuner2.find_start_of_message
    
    tuner3 = Tuning.new(nil, 'nppdvjthqldpwncqszvftbrmjlhg')
    assert_equal 23, tuner3.find_start_of_message
    
    tuner4 = Tuning.new(nil, 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg')
    assert_equal 29, tuner4.find_start_of_message
    
    tuner5 = Tuning.new(nil, 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw')
    assert_equal 26, tuner5.find_start_of_message
  end
end

# Solve Part 1:
tuner = Tuning.new('input.txt')
puts "Part 1 Solution: #{tuner.find_start_of_stream}"

# Solve Part 2:
tuner = Tuning.new('input.txt')
puts "Part 2 Solution: #{tuner.find_start_of_message}"
