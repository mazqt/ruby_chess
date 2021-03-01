require '../lib/piece.rb'
require '../lib/board.rb'
require '../lib/player.rb'
require '../lib/pawn.rb'
require '../lib/rook.rb'
require '../lib/knight.rb'
require '../lib/bishop.rb'
require '../lib/queen.rb'
require '../lib/king.rb'


describe Board do
  describe "#initialize" do
    #Nothing that needs to be tested, just a normal initialization with board assignements
  end

  describe "#validate_input" do
    context "when fed input that is too long" do
      it "returns false" do
        result = Board.validate_input("fgdga")
        expect(result).to eq(false)
      end
    end

    context "when fed input with the wrong letter" do
      it "returns false" do
        result = Board.validate_input("p3")
        expect(result).to eq(false)
      end
    end

    context "when fed input with the wrong number" do
      it "returns false" do
        result = Board.validate_input("h9")
        expect(result).to eq(false)
      end
    end

    context "when fed input that is reversed" do
      it "returns false" do
        result = Board.validate_input("4d")
        expect(result).to eq(false)
      end
    end

    context "when fed valid input" do
      it "returns true" do
        result = Board.validate_input("c4")
        expect(result).to eq(true)
      end
    end
  end

  describe "#convert_input" do
    context "when fed algebraic notation ie c6" do

      it "converts it into the appropriate board position" do
        result = Board.convert_input("c1")
        expect(result).to eq([0,2])
      end
    end
    context "when fed faulty notation ie l3 or c9" do
      it "returns false" do
        wrong_num = Board.convert_input("c9")
        wrong_let = Board.convert_input("l3")
        expect(wrong_let).to eq(false)
        expect(wrong_num).to eq(false)
      end
    end
  end

  describe "#move_piece" do
    context "when a move is legal and the path is clear" do
      subject(:starting_board) { described_class.new }
      before do
        starting_board.move_piece([1, 2], [2, 2])
      end
      it "the piece is moved to the desired location" do
        new_position = starting_board.board[2][2]
        expect(new_position.is_a?(Pawn)).to eq(true)
      end
      it "the old position is now empty" do
        old_position = starting_board.board[1][2]
        expect(old_position).to eq("_")
      end
    end
  end

  describe "#clear_path?" do
    context "when the path from d2 to d4, or d4 to d2," do
      context "is clear" do
        subject(:clear_vertical) { described_class.new }
        it "it returns true" do
          result = clear_vertical.clear_path?([1, 3], [3, 3])
          result_reverse = clear_vertical.clear_path?([3, 3], [1, 3])
          expect(result).to eq(true)
          expect(result_reverse).to eq(true)
        end
      end
      context "isn't clear" do
        subject(:blocked_vertical) { described_class.new }
        before do
          blocked_vertical.move_piece([6, 3], [2, 3])
        end
        it "it returns false" do
          result = blocked_vertical.clear_path?([1, 3], [3, 3])
          expect(result).to eq(false)
        end
      end
    end
    context "when the path from g4 to d4" do
      context "is clear" do
        subject(:clear_horizontal) { described_class.new }
        it "it returns true" do
          result = clear_horizontal.clear_path?([3, 6], [3, 3])
          expect(result).to eq(true)
        end
      end
      context "isn't clear" do
        subject(:blocked_horizontal) { described_class.new }
        before do
          blocked_horizontal.move_piece([6, 4], [3, 4])
        end
        it "it returns false" do
          result = blocked_horizontal.clear_path?([1, 6], [1, 3])
          expect(result).to eq(false)
        end
      end
    end
    context "when the path from d4 to f6" do
      context "is clear" do
        subject(:clear_diagonal) { described_class.new }
        it "it returns true" do
          result = clear_diagonal.clear_path?([3, 3], [5, 5])
          expect(result).to eq(true)
        end
      end
      context "is blocked" do
        subject(:blocked_diagonal) { described_class.new }
        before do
          blocked_diagonal.move_piece([6, 2], [4, 4])
        end
        it "returns false" do
          result = blocked_diagonal.clear_path?([3, 3], [5, 5])
          expect(result).to eq(false)
        end
      end
    end
    context "when the path from d4 to b6" do
      context "is clear" do
        subject(:clear_diagonal) { described_class.new }
        it "it returns true" do
          result = clear_diagonal.clear_path?([3, 3], [1, 5])
          expect(result).to eq(true)
        end
      end
      context "is blocked" do
        subject(:blocked_diagonal) { described_class.new }
        before do
          blocked_diagonal.move_piece([6, 2], [2, 4])
        end
        it "returns false" do
          result = blocked_diagonal.clear_path?([3, 3], [1, 5])
          expect(result).to eq(false)
        end
      end
    end
    context "when the path from d4 to b2" do
      context "is clear" do
        subject(:clear_diagonal) { described_class.new }
        it "it returns true" do
          result = clear_diagonal.clear_path?([3, 3], [1, 1])
          expect(result).to eq(true)
        end
      end
      context "is blocked" do
        subject(:blocked_diagonal) { described_class.new }
        before do
          blocked_diagonal.move_piece([6, 2], [2, 2])
        end
        it "returns false" do
          result = blocked_diagonal.clear_path?([3, 3], [1, 1])
          expect(result).to eq(false)
        end
      end
    end
    context "when the path from d4 to g1" do
      context "is clear" do
        subject(:clear_diagonal) { described_class.new }
        before do
          clear_diagonal.move_piece([1, 5], [2, 7])
        end
        it "it returns true" do
          result = clear_diagonal.clear_path?([3, 3], [0, 6])
          expect(result).to eq(true)
        end
      end
      context "is blocked" do
        subject(:blocked_diagonal) { described_class.new }
        it "returns false" do
          result = blocked_diagonal.clear_path?([3, 3], [0, 6])
          expect(result).to eq(false)
        end
      end
    end
  end

  describe "#capture" do
    context "when a piece is captured" do
      subject(:board) { described_class.new }
      it "it's added to the captured array" do
        piece = Rook.new("white")
        board.capture(piece)
        expect(board.captured_pieces.include?(piece)).to eq(true)
      end
    end
  end
  describe "#check" do
    context "when a king is in check (its position is a legal move with a clear path for another opposing piece)" do
      subject(:checked_board) { described_class.new }
      before do
        checked_board.move_piece([0, 4], [2, 4])
        checked_board.move_piece([7, 3], [5, 1])
      end
      it "it returns true" do
        result = checked_board.check("white")
        expect(result).to eq(true)
      end
    end
    context "when neither king is in check" do
      subject(:unchecked_board) { described_class.new }
      it "it returns false" do
        result_white = unchecked_board.check("white")
        result_black = unchecked_board.check("black")
        expect(result_white).to eq(false)
        expect(result_black).to eq(false)
      end
    end
  end

  describe "#checkmate" do
    context "when every possible move leads to check" do
      subject(:mated_board) { described_class.new }
      before do
        mated_board.move_piece([1, 5], [2, 5])
        mated_board.move_piece([1, 6], [3, 6])
        mated_board.move_piece([6, 4], [4, 4])
        mated_board.move_piece([7, 3], [3, 7])
      end
      it "it returns true" do
        result = mated_board.checkmate("white")
        expect(result).to eq(true)
      end
    end
    context "when there's a move to get out of check" do
      context "by moving your king" do
        subject(:escape_board) { described_class.new }
        before do
          escape_board.move_piece([0, 4], [2, 4])
          escape_board.move_piece([7, 3], [5, 4])
          escape_board.move_piece([1, 5], [2, 7])
        end
        it "it returns false" do
          result = escape_board.checkmate("white")
          expect(result).to eq(false)
        end
      end
      context "by blocking with another piece" do
        subject(:block_board) { described_class.new }
        before do
          block_board.move_piece([0, 4], [2, 4])
          block_board.move_piece([7, 3], [5, 4])
          block_board.move_piece([0, 3], [2, 3])
        end
        it "it returns false" do
          result = block_board.checkmate("white")
          expect(result).to eq(false)
        end
      end
      context "by killing an attacking piece" do
        subject(:kill_board) { described_class.new }
        before do
          kill_board.move_piece([0, 4], [2, 4])
          kill_board.move_piece([7, 3], [5, 4])
          kill_board.move_piece([0, 5], [2, 7])
        end
        it "it returns false" do
          result = kill_board.checkmate("white")
          expect(result).to eq(false)
        end
        context "but the opponents king is now in check or checkmate" do
          before do
          kill_board.move_piece([1, 4], [3, 7])
          kill_board.move_piece([2, 4], [0, 4])
          kill_board.move_piece([5, 4], [4, 4])
          kill_board.move_piece([6, 4], [4, 7])
          kill_board.move_piece([2, 7], [2, 6])
          kill_board.move_piece([1, 3], [2, 3])
          kill_board.move_piece([1, 5], [2, 5])
          end
          it "it returns false" do
            result = kill_board.checkmate("white")
            expect(result).to eq(false)
          end
        end
      end
    end
  end
end

describe Bishop do
  describe "#initialize" do
    context "if I look at the legal moves from c1" do
      subject(:bishop) { described_class.new("white") }
      it "it includes e3 and b2" do
        moves = bishop.legal_moves[[0, 2]]
        expect(moves.include?([2, 4])).to eq(true)
        expect(moves.include?([1, 1])).to eq(true)
      end

      it "it doesn't include d3 and e5" do
        moves = bishop.legal_moves[[0, 2]]
        expect(moves.include?([2, 3])).to eq(false)
        expect(moves.include?([4, 4])).to eq(false)
      end
    end
  end
end

describe King do
  describe "#initialize" do
    context "if I look at the legal moves from e4" do
      subject(:king) { described_class.new("white") }

      it "it includes e5 and f3" do
        moves = king.legal_moves[[3, 4]]
        expect(moves.include?([4, 4])).to eq(true)
        expect(moves.include?([2, 5])).to eq(true)
      end

      it "it doesn't include c2 or g6" do
        moves = king.legal_moves[[3, 4]]
        expect(moves.include?([1, 2])).to eq(false)
        expect(moves.include?([5, 6])).to eq(false)
      end
    end
  end
end

describe Knight do
  describe "#initialize" do
    context "if I look at the legal moves from d5" do
      subject(:knight) { described_class.new("white") }

      it "it includes e7 and b4" do
        moves = knight.legal_moves[[4, 3]]
        expect(moves.include?([6, 4])).to eq(true)
        expect(moves.include?([3, 1])).to eq(true)
      end

      it "it doesn't include g3 or h6" do
        moves = knight.legal_moves[[4, 3]]
        expect(moves.include?([2, 6])).to eq(false)
        expect(moves.include?([5, 7])).to eq(false)
      end
    end
  end
end

describe Pawn do
  describe "#initialize" do
    context "if the pawn is white," do
      subject(:white_pawn) { described_class.new("white") }
      context "the legal moves from d2" do
        it "are d3 and d4" do
          moves = white_pawn.legal_moves[[1, 3]]
          expect(moves.include?([2, 3])).to eq(true)
          expect(moves.include?([3, 3])).to eq(true)
        end
        it "does not include d1 or d5" do
          moves = white_pawn.legal_moves[[1, 3]]
          expect(moves.include?([0, 3])).to eq(false)
          expect(moves.include?([4, 3])).to eq(false)
        end
      end
      context "the legal captures from d2" do
        it "are c3 and e3" do
          captures = white_pawn.legal_captures[[1, 3]]
          expect(captures.include?([2, 2])).to eq(true)
          expect(captures.include?([2, 4])).to eq(true)
        end
        it "doesn't include c4 or b3" do
          captures = white_pawn.legal_captures[[1, 3]]
          expect(captures.include?([3, 2])).to eq(false)
          expect(captures.include?([2, 1])).to eq(false)
        end
      end
    end
    context "if the pawn is black" do
      subject(:black_pawn) { described_class.new("black") }
      context "the legal moves from d7" do
        it "are d6 and d5" do
          moves = black_pawn.legal_moves[[6, 3]]
          expect(moves.include?([5, 3])).to eq(true)
          expect(moves.include?([4, 3])).to eq(true)
        end
        it "doesn't include d8 or d4" do
          moves = black_pawn.legal_moves[[6, 3]]
          expect(moves.include?([7, 3])).to eq(false)
          expect(moves.include?([3, 3])).to eq(false)
        end
      end
      context "the legal captures from d7" do
        it "are c6 and e6" do
          captures = black_pawn.legal_captures[[6, 3]]
          expect(captures.include?([5, 2])).to eq(true)
          expect(captures.include?([5, 4])).to eq(true)
        end
        it "doesn't include b6 or e5" do
          captures = black_pawn.legal_captures[[6, 3]]
          expect(captures.include?([5, 1])).to eq(false)
          expect(captures.include?([4, 4])).to eq(false)
        end
      end
    end
  end
  describe "#promote" do
    context "when a white pawn has crossed the board and chooses to become a rook" do
      subject(:white_pawn) { described_class.new("white") }
      before do
        input = "rook"
        allow(white_pawn).to receive(:gets).and_return(input)
      end
      it "it can become a rook" do
        promoted_white_piece = white_pawn.promote
        expect(promoted_white_piece.is_a?(Rook)).to eq(true)
      end
    end
    context "when a white pawn has crossed the board and chooses to become a queen" do
      subject(:white_pawn) { described_class.new("white") }
      before do
        input = "queen"
        allow(white_pawn).to receive(:gets).and_return(input)
      end
      it "it can become a rook" do
        promoted_white_piece = white_pawn.promote
        expect(promoted_white_piece.is_a?(Queen)).to eq(true)
      end
    end
  end
end

describe Rook do
  describe "#initialize" do
    context "if I look at the legal moves from f4" do
      subject(:rook) { described_class.new("white") }
      it "it includes f6 and b4" do
        moves = rook.legal_moves[[3, 5]]
        expect(moves.include?([3, 1])).to eq(true)
        expect(moves.include?([5, 5])).to eq(true)
      end
      it "doesn't include e3 or d1" do
        moves = rook.legal_moves[[3, 5]]
        expect(moves.include?([2, 4])).to eq(false)
        expect(moves.include?([0, 3])).to eq(false)
      end
    end
  end
end

describe Queen do
  describe "#initialize" do
    context "if I look at the legal moves from e4" do
      subject(:queen) { described_class.new("white") }
      it "it includes b1 and a4" do
        moves = queen.legal_moves[[3, 4]]
        expect(moves.include?([0, 1])).to eq(true)
        expect(moves.include?([3, 0])).to eq(true)
      end
      it "it doesn't include a1 or h5" do
        moves = queen.legal_moves[[3, 4]]
        expect(moves.include?([0, 0])).to eq(false)
        expect(moves.include?([4, 7])).to eq(false)
      end
    end
  end
end
