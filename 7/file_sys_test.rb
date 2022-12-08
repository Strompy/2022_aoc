require 'minitest/autorun'
require 'minitest/pride'
require_relative './file_sys'


class FileSysTest < Minitest::Test
  def test_it_can_read_lines
    sys = FileSys.new('test_input.txt')
    assert_equal 23, sys.lines.size
  end
  
  def test_it_can_change_current_directory
    sys = FileSys.new('test_input.txt')
    assert_equal '/', sys.current_dir
    
    sys.change_current_directory('a')
    assert_equal ['/'], sys.previous_dir
    assert_equal 'a', sys.current_dir
    
    sys.change_current_directory('e')
    assert_equal ['/', 'a'], sys.previous_dir
    assert_equal 'e', sys.current_dir
    
    sys.change_current_directory('..')
    assert_equal ['/'], sys.previous_dir
    assert_equal 'a', sys.current_dir
  end
  
  def test_it_can_parse_file_structure
    sys = FileSys.new('test_input.txt')
    assert_equal '/', sys.current_dir
    sys.parse_file_structure
    
    assert_equal ['/'], sys.files.keys
    assert_equal [:txts, :total_size, 'a', 'd',], sys.files['/'].keys
    assert_equal [:txts, :total_size, 'e',], sys.files['/']['a'].keys
  end
  
  def test_it_can_create_plain_data
    sys = FileSys.new('test_input.txt')
    sys.parse_file_structure
    
    assert_equal 584, sys.files['/']['a']['e'][:txts][0].file_size
    assert_equal 'i', sys.files['/']['a']['e'][:txts][0].name
    
    assert_equal 29116, sys.files['/']['a'][:txts][0].file_size
    assert_equal 'f', sys.files['/']['a'][:txts][0].name
    assert_equal 2557, sys.files['/']['a'][:txts][1].file_size
    assert_equal 'g', sys.files['/']['a'][:txts][1].name
    assert_equal 62596, sys.files['/']['a'][:txts][2].file_size
    assert_equal 'h.lst', sys.files['/']['a'][:txts][2].name
    
    assert_equal 4060174, sys.files['/']['d'][:txts][0].file_size
    assert_equal 'j', sys.files['/']['d'][:txts][0].name
    assert_equal 8033020, sys.files['/']['d'][:txts][1].file_size
    assert_equal 'd.log', sys.files['/']['d'][:txts][1].name
    assert_equal 5626152, sys.files['/']['d'][:txts][2].file_size
    assert_equal 'd.ext', sys.files['/']['d'][:txts][2].name
    assert_equal 7214296, sys.files['/']['d'][:txts][3].file_size
    assert_equal 'k', sys.files['/']['d'][:txts][3].name
  end
  
  def test_it_can_sum_dir_size
    sys = FileSys.new('test_input.txt')
    sys.parse_file_structure
    sys.calculate_sizes(sys.files)
    
    assert_equal 584, sys.files['/']['a']['e'][:total_size]
    assert_equal 94853, sys.files['/']['a'][:total_size]
    assert_equal 24933642, sys.files['/']['d'][:total_size]
    assert_equal 48381165, sys.files['/'][:total_size]
  
    assert_equal 584, sys.file_size_by_dir['e']
    assert_equal 94853, sys.file_size_by_dir['a']
    assert_equal 24933642, sys.file_size_by_dir['d']
    assert_equal 48381165, sys.file_size_by_dir['/']
  end
  
  def test_it_can_solve_part_1
    sys = FileSys.new('test_input.txt')
    sys.parse_file_structure
    sys.calculate_sizes(sys.files)
    
    assert_equal 95437, sys.solve_part_1
  end
end

# SOLVE PART 1: 
sys = FileSys.new('input.txt')
sys.parse_file_structure
sys.calculate_sizes(sys.files)
puts "Part 1 Solution: #{sys.solve_part_1}"
