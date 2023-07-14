class Rope
  attr_reader :moves, :head, :tail, :tail_positions
  
  def initialize(input)
    @moves = IO.readlines(input, chomp: true).map(&:split)
    @head = [0, 0]
    @tail = [0, 0]
    # @tail_positions = []
    @tail_positions = Hash.new { |h, k| h[k] = 0 }
  end
  
  def run_all_moves
    moves.each do |move|
      move_rope(move)
    end
  end
  
  def move_rope(move)
    dir, num = move
    steps = num.to_i
    steps.times do |i|
      # @tail_positions << tail.clone
      @tail_positions[tail.clone] += 1
      move_head(dir)
      move_tail unless touching?
      alt_move_tail unless touching?
    end
  end
  
  def move_tail
    row_diff = head[0] - tail[0]
    col_diff = head[1] - tail[1]
    if row_diff.abs > 1 && col_diff.abs > 0
      diagonal_move(row_diff, col_diff)
      # if positive, increment 
      # if negative, decrement
    elsif col_diff.abs > 1 && row_diff.abs > 0
      diagonal_move(row_diff, col_diff)
    elsif row_diff.abs > 1
      straight_move(0, row_diff)
    elsif col_diff.abs > 1
      straight_move(1, col_diff)
    else
    end
  end
  
  # def alt_move_tail
  #   delta_x = head[0] - tail[0]
  #   delta_y = head[1] - tail[1]
  # 
  #   if delta_x.abs >= 2
  #     tail[0] += delta_x / delta_x.abs
  # 
  #     if delta_y.abs > 0
  #       tail[1] += delta_y / delta_y.abs
  #     end
  #   else
  #     tail[1] += delta_y / delta_y.abs
  # 
  #     if delta_x.abs > 0
  #       tail[0] += delta_x / delta_x.abs
  #     end
  #   end
  # end
  
  def touching?
    (head[0] - tail[0]).abs <= 1 && (head[1] - tail[1]).abs <= 1
  end
  
  def diagonal_move(row, col)
    if row.positive?
      tail[0] += 1
    elsif row.negative?
      tail[0] -= 1      
    end
    if col.positive?
      tail[1] += 1
    elsif col.negative?
      tail[1] -= 1      
    end
  end
  
  def straight_move(coord, amount)
    if amount.positive?
      tail[coord] += 1
    elsif amount.negative?
      tail[coord] -= 1
    end
  end
  
  def move_head(dir)
    case dir
    when "R"
      head[1] += 1
    when "L"
      head[1] -= 1
    when "U"
      head[0] -= 1
    when "D"
      head[0] += 1
    end
  end
end

# track the positions of the Tail
# Count all the positions that were visited at least once

# head and tail must always be touching

# if Head is two steps directly from Tail, tail must move ONE step straight toward head
# so they remain one place apart

# If head is in different row and column
# and the head and tail or not touching
# then tail moves one step diagonally
# so both row and column will change by one

moving_map = {
  [-1, 2] => [1, -1],
  [0, 2] => [0, -1],
  [1, 2] => [-1, -1],
  [2, 1] => [-1, -1],
  [2, 0] => [-1, 0],
  [2, -1] => [-1, 1],
  [1, -2] => [-1, 1],
  [0, -2] => [0, 1],
  [-1, -2] => [1, 1],
  [-2, -1] => [1, 1],
  [-2, 0] => [1, 0],
  [-2, 1] => [1, -1]
}

# part1
head = [0, 0]
tail = [0, 0]
tail_history = [[0, 0]]
File.readlines('test_input.txt').each do |line|
  break if line == "\n"
  direction, steps = line.chomp.split(' ')
  steps.to_i.times do
    case direction
    when 'U' then head[1] += 1
    when 'D' then head[1] -= 1
    when 'L' then head[0] -= 1
    when 'R' then head[0] += 1
    end

    relative_tail = [tail[0] - head[0], tail[1] - head[1]]
    if moving_map[relative_tail]
      tail[0] += moving_map[relative_tail][0]
      tail[1] += moving_map[relative_tail][1]
      tail_history << tail.dup
    end
  end
end
require "pry"; binding.pry
puts tail_history.uniq.count

# part2
# add diagonal moving
moving_map[[2, 2]] = [-1, -1]
moving_map[[2, -2]] = [-1, 1]
moving_map[[-2, -2]] = [1, 1]
moving_map[[-2, 2]] = [1, -1]
rope = 10.times.reduce([]) { |acc, i| acc << [0, 0]; acc }
tail_history = [[0, 0]]
File.readlines('input.txt').each do |line|
  break if line == "\n"
  direction, steps = line.chomp.split(' ')
  steps.to_i.times do
    case direction
    when 'U' then rope[0][1] += 1
    when 'D' then rope[0][1] -= 1
    when 'L' then rope[0][0] -= 1
    when 'R' then rope[0][0] += 1
    end

    (1..9).each do |i|
      relative_knot = [rope[i][0] - rope[i - 1][0], rope[i][1] - rope[i - 1][1]]
      if moving_map[relative_knot]
        rope[i][0] += moving_map[relative_knot][0]
        rope[i][1] += moving_map[relative_knot][1]
        tail_history << rope[i].dup if i == 9
      end
    end
  end
end
puts tail_history.uniq.count