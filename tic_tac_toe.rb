#!/usr/bin/ruby

def get_user_move
  print "Move: "
  input_string = gets.chomp

  puts

  # Check that the input is in the form [number] [number]
  if input_string =~ /^[0-2]\s+[0-2]$/
    return input_string.split.map! { |s| s.to_i }
  elsif input_string == "exit" or input_string == "quit"
    exit
  else
    return nil
  end
end

class Board
  def initialize
    @board = Array.new(3) { Array.new(3) {0} }
  end

  def draw_board
    (0...@board.length).each do |y|
      (0...@board[y].length).each do |x|

        case @board[y][x]
        when 0
          print ' '
        when 1
          print 'x'
        when 2
          print 'o'
        end

        if x < 2
          print '|'
        else
          puts
          if y < 2
            puts "-+-+-"
          end
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
user_move = true

while true
  board.draw_board
  puts

  if user_move
    input = get_user_move

    if input.nil?
      puts "Invalid user input"
      puts
      next
    end

    board.set_cell(input, 1)

#     user_move = false
  else
    # AI move will go here
  end
end

