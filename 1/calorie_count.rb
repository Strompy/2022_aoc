# FIND THE ELF CARRYING THE MOST CALORIES FROM

# Parse the input
# blank line seperates the elves from the
# sum the totals between the lines breaks, for each elf
# return the elf with the largest total

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
end

# Part 1
# puts CalorieCount.new('input.txt').find_most_calories

# Part 2
# puts CalorieCount.new('input.txt')

