require 'pry'
class ValueError < StandardError
end

class Board
  MINE = '*'
  EMPTY = ' '

  def self.transform(input)
    Board.new(input).draw
  end

  def initialize(input)
    @board = input
    @rows = @board.length - 2
    @columns = @board[0].length - 2
    validate
  end

  def draw
    @board.map.with_index do |row, row_index|
      row.chars.map.with_index do |value, column_index|
        if ['+', '-', '|', MINE].include?(value)
          value
        else
          number_of_mines(row_index, column_index) || EMPTY
        end
      end.join
    end
  end

  private

  def validate
    fail ValueError if @board.map(&:size).uniq.size != 1
    fail ValueError if faulty_border?
    fail ValueError if invalid_chars?
  end

  def faulty_border?
    valid_horizontal = '+' + '-' * @columns + '+'
    valid_vertical = '+' + '|' * @rows + '+'

    left_vertical = @board.map { |row| row[0] }.join
    right_vertical = @board.map { |row| row[-1] }.join
    top_horizontal = @board[0]
    bottom_horizontal = @board[-1]

    top_horizontal != valid_horizontal ||
      bottom_horizontal != valid_horizontal ||
      left_vertical != valid_vertical ||
      right_vertical != valid_vertical
  end

  def invalid_chars?
    inner_chars = @board.select.with_index { |_, i| (1..@rows).include?(i) }
    inner_chars.collect! { |row| row[1, row.size - 2] }

    inner_chars.any? { |row| /[^\s\*\d]/.match(row) }
  end

  def get_surrounding_coordinates(row, col)
    upper_row = [row - 1, 1].max
    lower_row = [row + 1, @rows].min
    left_col = [col - 1, 1].max
    right_col = [col + 1, @columns].min

    row_coords = [upper_row, row, lower_row].uniq
    column_coords = [left_col, col, right_col].uniq

    row_coords.product(column_coords).select { |x, y| !(x == row && y == col) }
  end

  def number_of_mines(row, col)
    surrounding_coordinates = get_surrounding_coordinates(row, col)

    result = surrounding_coordinates.count do |rows, columns|
      @board[rows][columns] == MINE
    end

    result if result > 0
  end
end
