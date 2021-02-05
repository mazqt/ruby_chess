class Pawn
  include Piece
  attr_reader :legal_moves

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
      if @colour == "white"
        moves << [(y + 1), x] if y < 7
        moves << [(y + 2) , x] if y == 1
      else
        moves << [(y - 1), x] if y > 0
        moves << [(y - 2), x] if y == 6
      end
      legal_moves[position] = moves
    end
    legal_moves
  end

end
