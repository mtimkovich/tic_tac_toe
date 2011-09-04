#!/usr/bin/ruby

def get_move
  print "Move: "
  gets.chomp.split.map! { |s| s.to_i }
  puts
end

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
          if y < 2
            puts "-+-+-"
          end
        else
          print '|'
        end
      end
    end
  end

  def set_cell(coor, value)
    x = coor[0]
    y = coor[1]

    @board[y][x] = value
  end
end

board = Board.new
board.draw_board
puts

print "Move: "
input = gets.chomp.split.map! { |s| s.to_i }
puts

board.set_cell(input, 1)
board.draw_board

