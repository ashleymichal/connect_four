require_relative "./connect_four/version.rb"
require_relative "./connect_four/core_extensions.rb"
require_relative "./connect_four/cell.rb"
require_relative "./connect_four/player.rb"
require_relative "./connect_four/board.rb"
require_relative "./connect_four/game.rb"

module ConnectFour
  # Your code goes here...
end

def white
  "\u26AA".encode('utf-8')
end

def black
  "\u26AB".encode('utf-8')
end

puts "Welcome to ConnectFour!"

print "Please enter a name for Player 1:  "
p1name = gets.chomp

print "...and a name for Player 2:  "
p2name = gets.chomp

p1 = ConnectFour::Player.new name: p1name, color: white
p2 = ConnectFour::Player.new name: p2name, color: black

while true
  game = ConnectFour::Game.new([p1, p2])
  game.play
end
# initialize game
# play game