# saddlepoint.rb
require 'pry'

class Matrix
  def initialize(matrix_string)
    @matrix = parse_data(matrix_string)
  end

  def saddle_points
    coordinates.reduce([]) do |saddle_point_set, (x, y)|
      this_number = rows[x][y]
      if this_number == rows[x].max && this_number == columns[y].min
        saddle_point_set << [x, y]
      else
        saddle_point_set
      end
    end
  end

  def rows
    @matrix
  end

  def columns
    @matrix.transpose
  end

  private

  def coordinates
    (0..rows.size - 1).to_a.product((0..columns.size - 1).to_a)
  end

  def parse_data(matrix_string)
    matrix_string.split("\n").map do |row_string|
      row_string.split.map(&:to_i)
    end
  end
end
