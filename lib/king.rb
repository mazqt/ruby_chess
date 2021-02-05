class King
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
      x_axis = position[0]
      x_plus = x_axis + 1
      x_minus = x_axis - 1
      y_axis = position[1]
      y_plus = y_axis + 1
      y_minus = y_axis - 1

      moves << [x_axis, y_minus] if y_minus >= 0
      moves << [x_axis, y_plus] if y_plus <= 7
      if x_plus <= 7
        moves << [x_plus, y_axis]
        moves << [x_plus, y_minus] if y_minus >= 0
        moves << [x_plus, y_plus] if y_plus <= 7
      end
      if x_minus >= 0
        moves << [x_minus, y_axis]
        moves << [x_minus, y_minus] if y_minus >= 0
        moves << [x_minus, y_plus] if y_plus <= 7
      end

      legal_moves[position] = moves
    end
    legal_moves
  end

end
