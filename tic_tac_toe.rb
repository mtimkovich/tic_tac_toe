#!/usr/bin/ruby

class Board
  def initialize
    @board = Array.new(3) { Array.new(3) {0} }
  end

  def draw_board
    (0...@board.length).each do |y|
      (0...@board[y].length).each do |x|
        if @board[y][x] == 0
          print ' '
        elsif @board[y][x] == 1
          print 'x'
        else @board[y][x] == 2
          print 'o'
        end

        if x == 2
          puts
        else
          print '|'
        end
      end
    end
  end

  def set_cell(x, y, value)
    @board[y][x] = value
  end
end

board = Board.new
board.draw_board
puts

board.set_cell(1, 1, 1)
board.draw_board
