#!/usr/bin/ruby

class Player
  attr_accessor :name, :symbol

  @@symbol = 1

  def initialize(n)
    @name = n
    @symbol = @@symbol

    @@symbol += 1
  end

  def invalid_input
    puts "Invalid user input"
    puts
  end

end

class AI < Player
  def get_move
    [0, 0]
  end

end

class User < Player
  def get_move
    print "#{@name}: "
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

  def game_status
    # Check for 3 in a row in rows
    @board.each_index do |y|
      (1..2).each do |i|
        if @board[y].count(i) == 3
          return true
        end
      end
    end

    # Check for 3 in a row in columns
    @board[0].each_index do |x|
      column = []
      @board.each_index do |y|
        column.push(@board[y][x])
      end
      (1..2).each do |i|
        if column.count(i) == 3
          return true
        end
      end
    end

    # Check diagonals for 3 in a row
    [0, 2].each do |r|
      x = r
      y = 0
      diagonal = []
      3.times do
        diagonal.push(@board[y][x])
        if r == 0
          x += 1
        else
          x -= 1
        end

        y += 1
      end

      (1..2).each do |i|
        if diagonal.count(i) == 3
          return true
        end
      end
    end

    return false
  end

end

board = Board.new

# print "How many players? "
# num_users = gets.chomp
num_users = "2"

players = []

case num_users
when "1"
  players[0] = User.new("Player 1")
  players[1] = AI.new("CPU")
when "2"
  players[0] = User.new("Player 1")
  players[1] = User.new("Player 2")
else
  puts "Invalid number of users"
  exit
end

game_over = false
e = players.cycle

while not game_over
  player = e.peek

  unless player.name == "CPU"
    board.draw_board
    puts
  end

  input = player.get_move

  if input.nil?
    player.invalid_input
    next
  end

  r = board.set_cell(input, player.symbol)

  if r.nil? 
    player.invalid_input
    next
  end

  game_over = board.game_status

  e.next
end

board.draw_board
puts
puts "GAME OVER"

