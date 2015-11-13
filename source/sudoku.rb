require 'pp'
class Sudoku
  attr_reader :board_arr
  def initialize(board_string)
    output = board_string.split('')
    @board_arr = []
    output.each_slice(9) {|row| @board_arr << row }

  end

  def solve
  end

  def board
  end

  # Returns a string representing the current state of the board
  def to_s
  end
end

test = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--"
)

pp test.board_arr