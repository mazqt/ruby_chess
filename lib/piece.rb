module Piece

    def create_board
    board = []

    8.times do |row|
      8.times do |column|
        board << [row, column]
      end
    end

    board
  end

end
