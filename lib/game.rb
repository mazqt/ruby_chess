require "yaml"
class Game

  def initialize(player1 = nil, player2 = nil, board = nil)
    @player1 = player1 || nil
    @player2 = player2 || nil
    @board = board || nil
  end

  def start_new_game
    puts "Enter the name of player 1, they will play as white"
    @player1 = Player.new(gets.chomp)
    puts "Enter the name of player 2, they will play as black"
    @player2 = Player.new(gets.chomp)
    @board = Board.new
  end

  def save_game
    time = Date.now.to_s
    Dir.mkdir("saves") unless Dir.exist? "saves"
    save = to_yaml
    filename = "saves/#{time}.txt"
    File.open(filename, "w"){ |somefile| somefile.puts save}
  end

  def to_yaml
    YAML.dump ({
      :player1 => @player1,
      :player2 => @player2,
      :board => @board
    })
  end

  def self.from_yaml(string)
    data = YAML.load(string)
    self.new(data[:player1], data[:player2], data[:board])
  end

end
