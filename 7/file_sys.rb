require_relative './plain_data'

class FileSys
  DEAFULT_HASH = Hash.new { |h, k| h[k] = 0 }
  MAX_DIR_SIZE = 100_000
  
  attr_reader :lines, :files, :current_dir, :previous_dir, :file_size_by_dir
  
  def initialize(input)
    @lines = IO.readlines(input, chomp: true)
    @files = { '/' => { txts: [], total_size: 0 } }
    @current_dir = '/'
    @previous_dir = []
    @file_size_by_dir = Hash.new { |h, k| h[k] = 0 }
  end
  
  def parse_file_structure
    lines.each_with_index do |line, index|
      next if index == 0
      
      parts = line.split(' ')
      if parts[0] == '$'
        change_current_directory(parts[2]) if parts[1] == 'cd' 
        # if ls then skip i guess, not sure I need it with this approach
      elsif parts[0] == 'dir'
        keys = [previous_dir, current_dir, parts[1]].flatten
        existing_directory = files.dig(keys)
        deep_set(files, keys, { txts: [], total_size: 0 }) if !existing_directory
      elsif parts[0].to_i.to_s == parts[0]
        keys = [previous_dir, current_dir].flatten
        plain_data = PlainData.new(*parts)
        deep_set_files(files, keys, plain_data)
      end
    end
  end
  
  def change_current_directory(new_dir)
    if new_dir == '..'
      # if .. then up one level
      @current_dir = @previous_dir.pop
    else
      # if letter then that is the new dir
      @previous_dir.push(current_dir)
      @current_dir = new_dir
    end
  end
  
  def deep_set(file_structure, keys, value)
    keys[0...-1].inject(file_structure) do |acc, h|
      acc.public_send(:[], h)
    end.public_send(:[]=, keys.last, value)
  end
  
  def deep_set_files(file_structure, keys, value)
    keys[0...-1].inject(file_structure) do |acc, h|
      acc.public_send(:[], h)
    end.public_send(:[], keys.last)[:txts] << value
  end
  
  def deep_set_total_size(file_structure, keys, value)
    @file_size_by_dir[keys.last] += value
    keys[0...-1].inject(file_structure) do |acc, h|
      acc.public_send(:[], h)
    end.public_send(:[], keys.last)[:total_size] += value
  end
  
  def calculate_sizes(dirs, recursive_dirs = [])
    sum = 0
    dirs.each do |directory|
      parent = directory[0]
      children = directory[1]
      if children.is_a?(Array)
        sum += children.sum(&:file_size)
      elsif children.is_a?(Hash)
        recursive_dirs << parent
        child_size = calculate_sizes(children.except(:total_size), recursive_dirs)
        next if child_size.is_a?(Hash)
        
        deep_set_total_size(files, recursive_dirs, child_size)
        recursive_dirs.pop
        sum += child_size
      end
    end
    sum
  end
  
  def solve_part_1
    small_dirs = file_size_by_dir.select do |dir, size|
      size <= 100000
    end
    require "pry"; binding.pry
    small_dirs.values.sum
  end
end

# FIND ALL DIRECTORIES WITH A SIZE SMALLER THAN 100_000
# THEN SUM THE SIZES OF THOSE DIRECTORIES

# input is a bunch of terminal commands and outputs
# lines starting with $ are commands
# everything else is output
# cd x means move into that x dir
# cd .. means move out/up one level
# cd / means move to the base dir
# / is the base dir
# ls lists contents of current dir
# 123 abc means file abc is 123 size
# dir xyz means xyz is a directory

class Directory
  attr_accessor :name, :parent, :subdirectories, :files

  def initialize(name, parent = nil)
    @name = name
    @parent = parent
    @subdirectories = {}
    @files = {}
  end

  def read(line)
    a, b = line.split(' ')
    if a == 'dir'
      @subdirectories[b] ||= Directory.new(b, self)
    else
      @files[b] = a.to_i
    end
  end

  def total_size
    subdirectories.values.map(&:total_size).sum + files.values.sum
  end

  def traverse
    [self, subdirectories.values.map(&:traverse)].flatten
  end
end

# read the input
root = Directory.new('/')
current_dir = root
File.open('test_input.txt', 'r') do |file|
  # skip the first line
  file.readline

  loop do
    break if file.eof?
    line = file.readline.chomp

    if line.start_with?('$')
      _, cmd, arg = line.split(' ')
      if cmd == 'cd'
        if arg == '..'
          current_dir = current_dir.parent
        else
          current_dir = current_dir.subdirectories[arg]
        end
      end
    else
      current_dir.read(line)
    end
  end
end

# part1
ans = root.traverse.reduce(0) do |sum, dir|
  size = dir.total_size
  sum += size if size <= 100_000
  sum
end
puts ans


# part2
puts root.traverse.map(&:total_size).select { |size| size >= root.total_size - 40_000_000 }.min