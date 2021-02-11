require 'byebug'
class Board
  attr_reader :board, :captured_pieces

  def initialize()
    @board = Array.new(8) { Array.new(8, "_") }
    populate_board()
    @captured_pieces = []
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

  def move_piece(from, to)
    piece = @board[from[0]][from[1]]
    new_pos = @board[to[0]][to[1]]
    capture(new_pos) if new_pos != "_"

    change_board(to, piece)
    change_board(from, "_")
  end

  def capture(piece)
    @captured_pieces << piece
    puts @captured_pieces
  end

  def change_board(position, value)
    @board[position[0]][position[1]] = value
  end

  def is_move_legal?(from, to)
    piece = @board[from[0]][from[1]]
    moves = piece.legal_moves[from]

    if !piece.is_a?(Pawn)
      return false if !moves.include?(to)
    else
      captures = piece.legal_captures[from]
      if @board[to[0]][to[1]] == "_"
        return false if !moves.include?(to)
      else
        return false if !captures.include?(to)
      end
    end
    true
  end

  def clear_path?(from, to)
    if from[1] == to[1]
      horizontal = from[1]
      ((from[0] + 1)...to[0]).each { |vertical| return false if @board[vertical][horizontal] != "_"} if to[0] > from[0]
      ((to[0] + 1)...from[0]).each { |vertical| return false if @board[vertical][horizontal] != "_"} if from[0] > to[0]
    elsif from[0] == to[0]
      vertical = from[0]
      ((from[1] + 1)...to[1]).each { |horizontal| return false if @board[vertical][horizontal] != "_" } if to[1] > from[1]
      ((to[1] + 1)...from[1]).each { |horizontal| return false if @board[vertical][horizontal] != "_"} if from[1] > to[1]
    else
      upward = to[0] > from[0] ? true : false
      rightward = to[1] > from[1] ? true : false
      distance = (from[0] - to[0]).abs
      if upward
        if rightward
          (1...distance).each { |dif| return false if @board[from[0] + dif][from[1] + dif] != "_"}
        else
          (1...distance).each { |dif| return false if @board[from[0] + dif][from[1] - dif] != "_"}
        end
      else
        if rightward
          (1...distance).each { |dif| return false if @board[from[0] - dif][from[1] + dif] != "_"}
        else
          (1...distance).each { |dif| return false if @board[from[0] - dif][from[1] - dif] != "_"}
        end
      end

    end
    true
  end

  def check
    white_king = find_king("white")
    black_king = find_king("black")

    @board.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        if piece != "_"
          if piece.colour == "white"
            return true if (is_move_legal?([y, x], black_king) && clear_path?([y, x], black_king))
          else
            return true if (is_move_legal?([y, x], white_king) && clear_path?([y, x], white_king))
          end
        end
      end
    end
    false
  end

  def find_king(colour)
    @board.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        return [y, x] if piece.is_a?(King) && colour == piece.colour
      end
    end
  end

end
