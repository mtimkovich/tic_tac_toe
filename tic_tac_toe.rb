#!/usr/bin/ruby

class Board
  def initialize
    @board = Array.new(3) { Array.new(3) }
  end

  def draw_board
    (0...@board.length).each do |y|
      (0...@board[y].length).each do |x|
        if @board[y][x].nil?
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
end

board = Board.new
board.draw_board
