class Bishop
  include Piece
  attr_reader :legal_moves

  def initialize(colour)
    @colour = colour
    @legal_moves = set_legal_moves()
  end

  def set_legal_moves
    mock_board = create_board()
    legal_moves = {}

    mock_board.each do |position|
      moves = []

      value_1 = position[0]
      value_2 = position[1]

      until value_1 == 7 || value_2 == 7
        value_1 += 1
        value_2 += 1
        moves << [value_1, value_2]
      end

      value_1 = position[0]
      value_2 = position[1]

      until value_1 == 0 || value_2 == 0
        value_1 -= 1
        value_2 -= 1
        moves << [value_1, value_2]
      end

      value_1 = position[0]
      value_2 = position[1]

      until value_1 == 0 || value_2 == 7
        value_1 -= 1
        value_2 += 1
        moves << [value_1, value_2]
      end

      value_1 = position[0]
      value_2 = position[1]

      until value_1 == 7 || value_2 == 0
        value_1 += 1
        value_2 -= 1
        moves << [value_1, value_2]
      end
      legal_moves[position] = moves
    end

    legal_moves
  end

end
