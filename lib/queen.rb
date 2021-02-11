class Queen
  include Piece
  attr_reader :legal_moves, :colour

   def initialize(colour)
    @colour = colour
    @legal_moves = set_legal_moves
  end

  def set_legal_moves
    mock_board = create_board()
    legal_moves = {}

    mock_board.each do |position|
      moves = []
      y = position[0]
      x = position[1]

      8.times do |new_coord|
        moves << [y, new_coord] if new_coord != x
        moves << [new_coord, x] if new_coord != y
      end

      until y == 7 || x == 7
        y += 1
        x += 1
        moves << [y, x]
      end

      y = position[0]
      x = position[1]

      until y == 0 || x == 0
        y -= 1
        x -= 1
        moves << [y, x]
      end

      y = position[0]
      x = position[1]

      until y == 0 || x == 7
        y -= 1
        x += 1
        moves << [y, x]
      end

      y = position[0]
      x = position[1]

      until y == 7 || x == 0
        y += 1
        x -= 1
        moves << [y, x]
      end
      legal_moves[position] = moves
    end
    legal_moves
  end

end
