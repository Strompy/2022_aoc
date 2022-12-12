class Treehouse
  attr_reader :grid
  
  def initialize(input)
    rows = IO.read(input).split
    @grid = rows.map { |r| r.split('').map(&:to_i) }
  end
  
  def visible_tree_count
    edge_count = grid.size * 4 - 4
    # interior_visible_count = 5
    edge_count + interior_visible_tree_count
  end
  
  def interior_visible_tree_count
    count = 0
    grid.each_with_index do |row, y_index|
      next if y_index == 0 || y_index == grid.size - 1
      row.each_with_index do |height, x_index|
        next if x_index == 0 || x_index == grid[y_index].size - 1
        
        # compare in each direction all shorter trees 
        count += 1 if visible?(height, y_index, x_index)
      end
    end
    count
  end
  
  def visible?(height, y, x)
    # navigate left
    return true if grid[y][0..(x-1)].all? { |tree| tree < height }
    # navigate right
    return true if grid[y][(x+1)..-1].all? { |tree| tree < height }
    # navigate up
    return true if grid[0..(y-1)].all? { |row| row[x] < height }
    # navigate down
    return true if grid[(y+1)..-1].all? { |row| row[x] < height }
    false
  end
end


# input is a grid of trees, each digit is height
# 0 shortest, 9 tallest
# A tree is visible is all the trees between it and an edge of the grid are shorter
# All trees on the edge are visible
# So only interior trees are eligible
# Including the edge tree, HOW MANY TREES ARE VISIBLE
