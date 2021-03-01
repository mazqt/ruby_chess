require "yaml"
class Game

  def initialize(player1 = nil, player2 = nil, board = nil, current_player = nil)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = current_player
  end

  def start_new_game
    puts "Enter the name of player 1, they will play as white"
    @player1 = Player.new(gets.chomp)
    @player1.colour = "white"
    @current_player = @player1
    puts "Enter the name of player 2, they will play as black"
    @player2 = Player.new(gets.chomp)
    @player2.colour = "black"
    @board = Board.new
  end

  def play

    loop do
    current_player = @current_player
    current_colour = current_player.colour
    waiting_colour = nil
    if current_colour == "white"
      waiting_colour = "black"
    else
      waiting_colour = "white"
    end

      @board.print_board
      puts "It's #{current_player.name}'s turn"
      input = ""
      from = ""
      to = ""
      loop do
        puts "Either input which piece to move in chess notation, i.e f4 or b2, or write save to save and exit the current game"
        input = gets.chomp
        return save_game if input.downcase == "save"
        if Board.validate_input(input)
          input = Board.convert_input(input)
          piece = @board.board[input[0]][input[1]]
          if piece == "_"
            puts "You've selected an empty spot"
          elsif piece.colour != current_colour
            puts "You've selected an opponents piece"
          else
            from = input
            puts "Choose where to move your piece or write save to save and exit the current game"
              input = gets.chomp
              return save_game if input.downcase == "save"
              if Board.validate_input(input)
                input = Board.convert_input(input)
                to = input
                if @board.is_move_legal?(from, to) && @board.clear_path?(from, to)
                  to = input
                elsif !@board.is_move_legal?(from, to)
                  puts "Your piece cannot legally move to that position, choose another move"
                  to = ""
                elsif !@board.clear_path?(from, to)
                  puts "The path for your piece isn't clear, choose another move"
                  to = ""
                else
                  hypothetical_board = Board.new(@board)
                  hypothetical_board.move_piece(from, to)
                  if hypothetical_board.check(current_colour)
                    puts "You can't put yourself in check or remain in check"
                    to = ""
                  end
                end
              end
            if to != ""
              break
            end
          end
        end
        puts "Please try again"
      end

      @board.move_piece(from, to)
      if @board.check(waiting_colour)
        if @board.checkmate(waiting_colour)
          puts "#{current_player.name} has won"
          return
        end
        puts "#{waiting_colour} is in check"
      end

      if current_player == @player1
        @current_player = @player2
      else
        @current_player = @player1
      end
    end

  end

  def save_game
    time = Time.now.to_s
    Dir.mkdir("saves") unless Dir.exist? "saves"
    save = to_yaml
    filename = "saves/#{time}.txt"
    File.open(filename, "w"){ |somefile| somefile.puts save}
  end

  def self.load_game
    saves = Dir.entries("saves")
    saves = saves.delete_if { |filename| filename == ".." || filename == "." }
    puts "The following saved games exist :"
    saves.each_with_index { |save, index| puts "Index: #{index} Name: #{save}"  }
    puts "Select a save by entering the corresponding index number. If you enter a non-number value you will be given the first save in the column."

    loop do
      choice = gets.chomp.to_i
      if choice >= 0 && choice < saves.length
        save_file = saves[choice]
        puts "You've selected #{save_file}"
        save_data = File.read("saves/#{save_file}")
        return Game.from_yaml(save_data)
      end
    end
  end

  def to_yaml
    YAML.dump ({
      :player1 => @player1,
      :player2 => @player2,
      :board => @board,
      :current_player => @current_player
    })
  end

  def self.from_yaml(string)
    data = YAML.load(string)
    self.new(data[:player1], data[:player2], data[:board], data[:current_player])
  end

end
