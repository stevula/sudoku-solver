require 'pp'

class Sudoku
  def initialize(board_string)
    @numbers = *"1".."9"

    @board = []
    board_string.split(//).each_slice(9) { |row| @board << row }
  end

  def show_row(row_number)
    @board[row_number]
  end

  def show_column(column_number)
    @board.transpose[column_number]
  end

  def show_ennead(ennead_number)
    ennead = []
    ennead_starting_row = ennead_number / 3 * 3
    ennead_starting_column = ennead_number % 3 * 3

    ennead += @board[ennead_starting_row][ennead_starting_column..ennead_starting_column + 2]
    ennead += @board[ennead_starting_row + 1][ennead_starting_column..ennead_starting_column + 2]
    ennead += @board[ennead_starting_row + 2][ennead_starting_column..ennead_starting_column + 2]

    ennead
  end

  def get_ennead_of(row_number, column_number)
    possible_enneads = []

    if row_number.between?(0, 2)
      possible_enneads = *0..2
    elsif row_number.between?(3, 5)
      possible_enneads = *3..5
    else
      possible_enneads = *6..8
    end

    if column_number.between?(0, 2)
      possible_enneads.delete_if { |number| ![0, 3, 6].include? number }
    elsif column_number.between?(3, 5)
      possible_enneads.delete_if { |number| ![1, 4, 7].include? number }
    else
      possible_enneads.delete_if { |number| ![2, 5, 8].include? number }
    end

    possible_enneads[0]
  end

  def get_possible_values(row_number, column_number)
    ennead_number = get_ennead_of(row_number, column_number)
    @numbers - show_row(row_number) - show_column(column_number) - show_ennead(ennead_number)
  end

  def guess
  end

  def solved?
    solved = true

    test_number = 0
    9.times do
      solved = false if show_row(test_number).sort    != @numbers
      solved = false if show_column(test_number).sort != @numbers
      solved = false if show_ennead(test_number).sort != @numbers
      test_number += 1
    end

    solved
  end

  def solve
    200.times do
      @board.each_with_index do |row, row_number|
        row.each_with_index do |value, column_number|
          if value == "-"
            possible_values = get_possible_values(row_number, column_number)
            @board[row_number][column_number] = possible_values[0] if possible_values.length == 1
          end
        end
      end
    end

    puts "Solved!"
  end

  # Returns a string representing the current state of the board
  def to_s
    @board.each { |row| puts row.to_s }
  end
end

game_1 = Sudoku.new("1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--")
game_2 = Sudoku.new("--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3")
game_6 = Sudoku.new("---6891--8------2915------84-3----5-2----5----9-24-8-1-847--91-5------6--6-41----")
game_1.to_s
# pp game_1.show_row(0)
# pp game_1.show_column(0)
# pp game_1.show_ennead(0)
# pp game_1.show_ennead(8)
# p game_1.get_ennead_of(0, 0)
# p game_1.get_ennead_of(4, 5)
# p game_1.get_ennead_of(8, 8)
# p game_1.get_possible_values(2, 2)
# p game_1.solved?
game_1.solve
game_1.to_s
p game_1.solved?

# 0:  0,  1,  2,     9, 10, 11,    18, 19, 20
# 1:  3,  4,  5,    12, 13, 14,    21, 22, 23
# 2:  6,  7,  8,    15, 16, 17,    24, 25, 26

# 3: 27, 28, 29,    36, 37, 38,   45, 46, 47
# 4: 30, 31, 32,    39, 40, 41,   48, 49, 50
# 5: 33, 34, 35,    42, 43, 44,   51, 52, 53

# 6: 54 ..                        72, 73, 74
# 7: 57 ..                        75, 76, 77
# 8: 60, 61, 62,   69, 70, 71,    78, 79, 80

# [["1", "-", "5", "8", "-", "2", "-", "-", "-"]
#  ["-", "9", "-", "-", "7", "6", "4", "-", "5"]
#  ["2", "-", "-", "4", "-", "-", "8", "1", "9"]
#  ["-", "1", "9", "-", "-", "7", "3", "-", "6"]
#  ["7", "6", "2", "-", "8", "3", "-", "9", "-"]
#  ["-", "-", "-", "-", "6", "1", "-", "5", "-"]
#  ["-", "-", "7", "6", "-", "-", "-", "3", "-"]
#  ["4", "3", "-", "-", "2", "-", "5", "-", "1"]
#  ["6", "-", "-", "3", "-", "8", "9", "-", "-"]]