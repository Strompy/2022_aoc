class SupplyStacks
  attr_reader :stacks, :directions
  
  def initialize(input)
    lines = IO.readlines(input, chomp: true)
    breakpoint = lines.find_index ""
    @stacks = []
    @directions = []
    # create needed number of stacks
    num_of_stacks = lines[breakpoint-1][-2].to_i
    num_of_stacks.times do |i|
      @stacks << []
    end
    # find letter postions
    stack_nums = parse_numbers(lines[breakpoint-1])
    letter_postions = stack_nums.map do |num|
      lines[breakpoint-1].chars.find_index(num)
    end
    # sort letters into stacks
    (breakpoint-1).times do |i|
      chars = lines[i].chars
      stack_chars = chars.values_at(*letter_postions)
      stack_chars.each_with_index do |char, index|
        next if char == " "
        @stacks[index].unshift(char)
      end
    end
    # parse directions
    (breakpoint+1...lines.size).each_with_index do |i|
      @directions << parse_numbers(lines[i])
    end
  end
  
  def parse_numbers(line)
    # grab just numbers from string
    line.scan(/\d+/)
  end
  
  def move_crate(direction)
    num_of_moves, from, to = direction.map(&:to_i)
    num_of_moves.times do |i|
      crate = @stacks[from - 1].pop
      @stacks[to - 1].push(crate)
    end
  end
  
  def execute_directions!
    directions.each do |direction|
      move_crate(direction)
    end
  end
  
  def return_message
    @stacks.map do |stack|
      stack.last
    end.join
  end
end

# supplies are stored in stacks of crates
# the crates need to be rearranged
# Tower of hanoi style

# start with drawing of crate stacks and directions
# crates are moved individually not as stacks, so orders get reversed when moving multiple
# Find which create will end up ON TOP OF EACH STACK