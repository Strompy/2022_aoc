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
    skip
    sys = FileSys.new('test_input.txt')
    assert_equal '/', sys.current_dir
    sys.parse_file_structure
    # require "pry"; binding.pry
    assert_equal ['/'], sys.files.keys
    assert_equal ['a', 'd'].sort, sys.files['/'].keys.sort
    assert_equal ['e'].sort, sys.files['/']['a'].keys.sort
  end
end