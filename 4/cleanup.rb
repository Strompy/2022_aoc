class Cleanup
  attr_reader :pairs
  
  def initialize(input)
    @pairs = IO.readlines(input, chomp: true)
  end
  
  def fully_contained?(pair)
    first, second = pair.split(',')
    start_1, end_1 = first.split('-')
    start_2, end_2 = second.split('-')
    first_contains_second(start_1, end_1, start_2, end_2) || second_contains_first(start_1, end_1, start_2, end_2)
  end
  
  def first_contains_second(start_1, end_1, start_2, end_2)
    start_1 <= start_2 && end_1 >= end_2
  end
  
  def second_contains_first(start_1, end_1, start_2, end_2)
    start_2 <= start_1 && end_2 >= end_1
  end
  
  def count_fully_contained_pairs
    pairs.map { |pair| fully_contained?(pair) }.count(true)
  end
  
  def overlap?(pair)
    first, second = pair.split(',')
    start_1, end_1 = first.split('-').map(&:to_i)
    start_2, end_2 = second.split('-').map(&:to_i)
    (start_1..end_1).include?(start_2) || (start_2..end_2).include?(start_1)
  end
  
  def count_overlapping_pairs
    pairs.map { |pair| overlap?(pair) }.count(true)
  end
end



# elves  are cleaning up the camp by section
# each section has a unique ID
# each elf is assigned a range of IDs
# there is overlap between the ranges
# input is the combined ranges of two elves, two ranges per line
# some ranges full contain their partner
# count the number of ranges that fully inlcude their partner