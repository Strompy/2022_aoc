class Tuning
  attr_reader :stream
  
  def initialize(input = nil, stream = nil)
    @stream = stream ||IO.read(input).chomp
  end
  
  def find_start_of_stream
    chars = []
    stream.chars.each_with_index do |char, index|
      chars << char
      next if index < 3
      return (index + 1) if chars.last(4) == chars.last(4).uniq
    end
  end
  
  def find_start_of_message
    chars = []
    stream.chars.each_with_index do |char, index|
      chars << char
      next if index < 13
      return (index + 1) if chars.last(14) == chars.last(14).uniq
    end
  end
end

# you have a malfunctioning comms device
# It needs to lock on to the signal of the other elves
# Create a routine to find the start-of-signal packet in a datastream
# The packet is a sequence of 4 different chars
# Goal: Find the first position where the first four unique chars are
# FIND THE NUMBER OF CHARS FROM THE BEGINNING TO THE LAST OF THE FOUR CHARS (START OF SIGNAL PACKET)
