class CalorieCount
  attr_reader :elves
  
  def initialize(input)
    @elves = IO.read(input).split("\n\n").map do |elf|
      elf.split.map(&:to_i)
    end
  end
  
  def find_most_calories
    # part 1
    elves.map(&:sum).max
  end
  
  def sum_top_three
    # part 2
    elves.map(&:sum).max(3).sum
  end
end

# Part 1
counter = CalorieCount.new('input.txt')
puts "Part 1 answer: #{counter.find_most_calories}"

# Part 2
puts "Part 2 answer: #{counter.sum_top_three}"
