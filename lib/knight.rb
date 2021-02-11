class Knight
  include Piece
  attr_reader :legal_moves, :colour

   def initialize(colour)
    @colour = colour
    @legal_moves = set_legal_moves()
  end

  def set_legal_moves
    mock_board = create_board()
    legal_moves = {}

    mock_board.each do |position|
      moves = []
      moves << [(position[0] - 1), (position[1] - 2)]
      moves << [(position[0] + 1), (position[1] - 2)]
      moves << [(position[0] + 2), (position[1] - 1)]
      moves << [(position[0] + 2), (position[1]) + 1]
      moves << [(position[0] + 1), (position[1] + 2)]
      moves << [(position[0] - 1), (position[1] + 2)]
      moves << [(position[0] - 2), (position[1] + 1)]
      moves << [(position[0] - 2), (position[1] - 1)]
      moves.reject! { |move| move[0] > 7 || move[0] < 0 || move[1] > 7 || move[1] < 0}
      legal_moves[position] = moves
    end

    legal_moves

  end

end
