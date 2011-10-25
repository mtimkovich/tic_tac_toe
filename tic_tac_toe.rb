#!/usr/bin/ruby

class Player
  attr_accessor :name, :symbol

  @@symbol = 1

  def initialize(n, board)
    @name = n
    @symbol = @@symbol

    @@symbol += 1

    if not board.nil?
      @board = board
    end

    if @symbol == 1
      @other_symbol = 2
    else
      @other_symbol = 1
    end
  end

  def invalid_input(msg)
    puts msg
    puts
  end
end

class AI < Player
  def get_move
    # Start with @symbol to the CPU plays a winning move over a defensive one
    [@symbol, @other_symbol].each do |s|
      # Check for 2 in a row in rows
      @board.each_index do |y|
        if @board[y].count(s) == 2 and @board[y].count(0) == 1
          return [@board[y].index(0), y]
        end
      end

      # Check for 2 in a row in columns
      @board[0].each_index do |x|
        column = []
        @board.each_index do |y|
          column.push(@board[y][x])
        end

        if column.count(s) == 2 and column.count(0) == 1
          return [x, column.index(0)]
        end
      end

      # Check diagonals for 2 in a row
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

        if diagonal.count(s) == 2 and diagonal.count(0) == 1
          i = diagonal.index(0)

          return [(r-i).abs, i]
        end
      end
    end

    return nil
  end

  def reset(board)
    @board = board
  end
end

class User < Player
  def get_move
    print "#{@name}: "
    input_string = gets.chomp

    puts

    # Check that the input is in the form [number] [number]
    if input_string =~ /^\s*[0-2]\s+[0-2]\s*$/
      return input_string.split.map { |s| s.to_i }
    elsif input_string == "exit" or input_string == "quit"
      exit
    else
      return nil
    end
  end
end

class Board
  attr_accessor :board

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
    puts
  end

  def get_cell(coor)
    x, y = coor.drop(0) 

    @board[y][x]
  end

  def set_cell(coor, value)
    x, y = coor.drop(0)

    if @board[y][x] == 0
      @board[y][x] = value
    else
      nil
    end
  end

  def game_status
    (1..2).each do |i|
      # Check for 3 in a row in rows
      @board.each_index do |y|
        if @board[y].count(i) == 3
          return i
        end
      end

      # Check for 3 in a row in columns
      @board[0].each_index do |x|
        column = []
        @board.each_index do |y|
          column.push(@board[y][x])
        end
        if column.count(i) == 3
          return i
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

        if diagonal.count(i) == 3
          return i
        end
      end
    end

    # Check for a draw
    # A draw is when there are no 0s left on the board
    zeros = 0
    @board.each_index do |y|
      if @board[y].count(0) == 0
        zeros += 1
      end
    end

    if zeros == 3
      return 0
    end

    return false
  end

  def reset
    @board = Array.new(3) { Array.new(3) {0} }
  end
end

board = Board.new

# print "How many players? "
# num_users = gets.chomp
num_users = "1"

players = []

case num_users
when "1"
  players[0] = User.new("Player 1", nil)
  players[1] = AI.new("CPU", board.board)
when "2"
  players[0] = User.new("Player 1", nil)
  players[1] = User.new("Player 2", nil)
else
  puts "Invalid number of users"
  exit
end

game_over = false
e = players.cycle

while true
  while not game_over
    player = e.peek

    unless player.name == "CPU"
      board.draw_board
    end

    input = player.get_move

    if input.nil?
      player.invalid_input "Invalid move"

      if player.name == "CPU"
        e.next
      end

      next
    end

    r = board.set_cell(input, player.symbol)

    if r.nil? 
      player.invalid_input "Could not set cell"
      next
    end

    # Check if the game is over
    # game_over contains the winning players symbol
    # on draw, it contains 0
    game_over = board.game_status

    e.next
  end

  board.draw_board

  if game_over == 0
    puts "DRAW"
  else
    players.each do |player|
      if player.symbol == game_over
        puts "#{player.name.upcase} WINS"
      end
    end
  end

  puts "GAME OVER"
  puts

  print "Play again? [Y/n] "

  case gets.chomp.downcase
  when "y"
    board.reset
    game_over = false
    e = players.cycle
    if num_users == "1"
      players[1].reset(board.board)
    end
  when "n"
    break
  end

  puts
end

