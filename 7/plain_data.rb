class PlainData
  attr_reader :file_size, :name
  
  def initialize(file_size, name)
    @file_size = file_size.to_i
    @name = name
  end
end