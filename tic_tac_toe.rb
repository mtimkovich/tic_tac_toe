#!/usr/bin/ruby

def get_user_move
  print "Move: "
  input_string = gets.chomp

  puts

  # Check that the input is in the form [number] [number]
  if input_string =~ /^\s*[0-2]\s+[0-2]\s*$/
    input_string.split.map { |s| s.to_i }
  elsif input_string == "exit" or input_string == "quit"
    exit
  else
    nil
  end
end

def invalid_input
  puts "Invalid user input"
  puts
end

class AI
end

class Board
  def initialize
    @board = Array.new(3) { Array.new(3) {0} }
  end

  def draw_board
    @board.each_index do |y|
      @board[y].each_index do |x|

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

  def get_cell(coor)
    x, y = coor[0..1]

    @board[y][x]
  end

  def set_cell(coor, value)
    x, y = coor[0..1]

    if @board[y][x] == 0
      @board[y][x] = value
    else
      nil
    end
  end
end

board = Board.new
hal = AI.new

user_move = true

while true
  board.draw_board
  puts

  if user_move
    input = get_user_move

    if input.nil?
      invalid_input
      next
    end

    r = board.set_cell(input, 1)

    if r.nil? 
      invalid_input
      next
    end

#     user_move = false
  else
    # AI move will go here
  end
end

