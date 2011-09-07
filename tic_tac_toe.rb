#!/usr/bin/ruby

def invalid_input
  puts "Invalid user input"
  puts
end

class AI
  def get_move
  end
end

class User
  @@symbol = 1

  def initialize(n)
    @name = n

    # @symbol is unique to the player
    # @@symbol is static, and incriments every time a user is created
    @symbol = @@symbol

    @@symbol += 1
  end

  def get_symbol
    @symbol
  end

  def get_move
    puts @name
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

num_users = 2

players = []

if num_users == 1
  players[0] = User.new("Player 1")
  players[1] = AI.new("CPU")
elsif num_users == 2
  players[0] = User.new("Player 1")
  players[1] = User.new("Player 2")
end

game_over = false
e = players.cycle

while not game_over
  board.draw_board
  puts

  player = e.peek

  input = player.get_move

  if input.nil?
    invalid_input
    next
  end

  r = board.set_cell(input, player.get_symbol)

  if r.nil? 
    invalid_input
    next
  end

  e.next
end

