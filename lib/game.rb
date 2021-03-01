class Game

  def initialize()
    @player1 = nil
    @player2 = nil
    @board = nil
  end

  def start_new_game
    puts "Enter the name of player 1, they will play as white"
    @player1 = Player.new(gets.chomp)
    puts "Enter the name of player 2, they will play as black"
    @player2 = Player.new(gets.chomp)
    @board = Board.new
  end

end
