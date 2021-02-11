class King
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
      y_axis = position[0]
      y_plus = y_axis + 1
      y_minus = y_axis - 1
      x_axis = position[1]
      x_plus = x_axis + 1
      x_minus = x_axis - 1

      moves << [y_axis, x_minus] if x_minus >= 0
      moves << [y_axis, x_plus] if x_plus <= 7
      if y_plus <= 7
        moves << [y_plus, x_axis]
        moves << [y_plus, x_minus] if x_minus >= 0
        moves << [y_plus, x_plus] if x_plus <= 7
      end
      if y_minus >= 0
        moves << [y_minus, x_axis]
        moves << [y_minus, x_minus] if x_minus >= 0
        moves << [y_minus, x_plus] if x_plus <= 7
      end

      legal_moves[position] = moves
    end
    legal_moves
  end

end
