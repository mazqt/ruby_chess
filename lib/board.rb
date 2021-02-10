require 'byebug'
class Board
  attr_reader :board

  def initialize()
    @board = Array.new(8) { Array.new(8, "_") }
    populate_board()
  end

  def populate_board
    8.times do |index|
      @board[0][index] = Rook.new("white") if index == 0 || index == 7
      @board[0][index] = Knight.new("white") if index == 1 || index == 6
      @board[0][index] = Bishop.new("white") if index == 2 || index == 5
      @board[0][index] = Queen.new("white") if index == 3
      @board[0][index] = King.new("white") if index == 4
    end

    8.times do |index|
      @board[1][index] = Pawn.new("white")
    end

    8.times do |index|
      @board[6][index] = Pawn.new("black")
    end

    8.times do |index|
      @board[7][index] = Rook.new("black") if index == 0 || index == 7
      @board[7][index] = Knight.new("black") if index == 1 || index == 6
      @board[7][index] = Bishop.new("black") if index == 2 || index == 5
      @board[7][index] = Queen.new("black") if index == 3
      @board[7][index] = King.new("black") if index == 4
    end
  end

  def validate_input(input)
    letters = "abcdefgh"
    numbers = "12345678"

    values = input.split("")
    return false if values.length != 2
    return false if !letters.include?(values[0])
    return false if !numbers.include?(values[1])
    true
  end

  def convert_input(input)
    return false if !validate_input(input)
    letter_to_vertical = {
      "a" => 0,
      "b" => 1,
      "c" => 2,
      "d" => 3,
      "e" => 4,
      "f" => 5,
      "g" => 6,
      "h" => 7
    }

    values = input.split("")
    board_position = []
    board_position << values[1].to_i - 1
    board_position << letter_to_vertical[values[0]]
    board_position
  end

  def move_piece(piece_pos, end_pos)
<<<<<<< HEAD
=======
    piece_pos = convert_input(piece_pos)
    end_pos = convert_input(end_pos)
>>>>>>> bc4e56eac56e4cdb53da634d94f5217235bbc60b
    piece = @board[piece_pos[0]][piece_pos[1]]

    change_board(end_pos, piece)
    change_board(piece_pos, "_")
  end

  def change_board(position, value)
    @board[position[0]][position[1]] = value
  end

  def is_move_legal?(piece_pos, end_pos)
    piece_pos = convert_input(piece_pos)
    end_pos = convert_input(end_pos)
    piece = @board[piece_pos[0]][piece_pos[1]]
    moves = piece.legal_moves[piece_pos]

    if !piece.is_a?(Pawn)
      return false if !moves.include?(end_pos)
    else
      captures = piece.legal_captures[piece_pos]
      return false if !moves.include?(end_pos) && !captures.include?(end_pos)
    end
  end

end
