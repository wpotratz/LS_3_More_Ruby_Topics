require 'pry'

class Queens
  attr_reader :white, :black
  def initialize(white: [0,3], black: [7, 3])
    raise ArgumentError if white == black
    @white = white
    @black = black
    @board = Array.new(8) { Array.new(8, '_') }
    mark_board
  end
  
  def to_s
    @board.map { |row| row.join(' ') }.join("\n")
  end

  def mark_board
    @board[white[0]][white[1]] = 'W'
    @board[black[0]][black[1]] = 'B'
  end

  def attack?
    (white[0] - black[0]).abs == (white[1] - black[1]).abs ||
      white[0] == black[0] ||
      white[1] == black[1]
  end
end

#binding.pry