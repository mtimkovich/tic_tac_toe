#!/usr/bin/ruby

board = Array.new(3, Array.new(3))

(0...board.length).each do |i|
  (0...board[i].length).each do |j|
    puts "(#{i},#{j})"
  end
end

