class Rucksack
  attr_reader :sacks, :priorities
  
  def initialize(input)
    @sacks = IO.readlines(input, chomp: true).map { |l| l.split("") }
    @priorities = Hash[[*('a'..'z'), *('A'..'Z')].zip([*1..52])]
  end
  
  def find_shared_item(sack)
    compartment = sack.size / 2
    first, second = sack.each_slice(compartment).to_a
    (first & second).first
  end
  
  def find_badge(group)
    (group[0] & group[1] & group[2]).first
  end
  
  def find_priority(letter)
    priorities[letter]
  end

  
  def sum_priorities
    sacks.sum do |sack|
      letter = find_shared_item(sack)
      find_priority(letter)
    end
  end
  
  def sum_badge_priorities
    sacks.each_slice(3).sum do |group|
      letter = find_badge(group)
      find_priority(letter)
    end
  end
end

# each ruckstack has two compartments
# Items are certain types and go into one specific compartment
# input is a list of all items in each rucksack
# find the error (item in wrong compartment) for each rucksack
# exactly one error per rucksack
# each rucksack has an equal number of items per compartment

# Upper and lower case are differnt items
# One input line is one rucksack
# Items are given priority number: 
# a..z == a..26
# A..Z 27..52

# Find matching letter from each half
# Assign letter priority number
# Sum the priority numbers

# part 2
# elves divived into groups of 3
# elves carry badge for their group
# the badge is the only item shared between all three
# find the one common item (badge) shared between all three elves
# each three consecutive lines are a group of elves
