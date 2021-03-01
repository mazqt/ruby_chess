require './lib/piece.rb'
require './lib/board.rb'
require './lib/player.rb'
require './lib/pawn.rb'
require './lib/rook.rb'
require './lib/knight.rb'
require './lib/bishop.rb'
require './lib/queen.rb'
require './lib/king.rb'
require "./lib/game.rb"

game = nil
input = nil

loop do
  puts "Do you want to start a new game or load an old one? (new/load)"
  input = gets.chomp.downcase
  if input == "new" || input == "load"
    break
  end
end

if input == "load"
  game = Game.load_game
else
  game = Game.new
  game.start_new_game
end

game.play

