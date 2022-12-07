require_relative './plain_data'

class FileSys
  attr_reader :lines, :files, :current_dir, :previous_dir
  
  def initialize(input)
    @lines = IO.readlines(input, chomp: true)
    # @files = { files: [] }
    @files = { '/' => {} }
    @current_dir = '/'
    @previous_dir = []
  end
  
  def parse_file_structure
    lines.each_with_index do |line, index|
      next if index == 0
      
      parts = line.split(' ')
      # if $ then run command
      if parts[0] == '$'
        # require "pry"; binding.pry
        # cd then change current_dir 
        change_current_directory(parts[2]) if parts[1] == 'cd' 
        # if ls then skip i guess, not sure I need it with this approach
      # elsif dir then create new hash key
      elsif parts[0] == 'dir'
        # files[current_dir][char] = { files: [] }
        
      # elseif num then create new file
      elsif parts[0].to_i.to_s == parts[0]
        # files[current_dir][:files] << File.new
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