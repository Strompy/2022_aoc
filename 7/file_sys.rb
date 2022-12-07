require_relative './plain_data'

class FileSys
  DEAFULT_HASH = Hash.new { |h, k| h[k] = {} }
  attr_reader :lines, :files, :current_dir, :previous_dir
  
  def initialize(input)
    @lines = IO.readlines(input, chomp: true)
    @files = { '/' => { txts: [] } }
    @current_dir = '/'
    @previous_dir = []
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
        deep_set(files, keys, { txts: [] }) if !existing_directory
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
end

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