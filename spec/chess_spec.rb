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
    subject(:validate_board) { described_class.new }

    context "when fed input that is too long" do
      it "returns false" do
        result = validate_board.validate_input("fgdga")
        expect(result).to eq(false)
      end
    end

    context "when fed input with the wrong letter" do
      it "returns false" do
        result = validate_board.validate_input("p3")
        expect(result).to eq(false)
      end
    end

    context "when fed input with the wrong number" do
      it "returns false" do
        result = validate_board.validate_input("h9")
        expect(result).to eq(false)
      end
    end

    context "when fed input that is reversed" do
      it "returns false" do
        result = validate_board.validate_input("4d")
        expect(result).to eq(false)
      end
    end

    context "when fed valid input" do
      it "returns true" do
        result = validate_board.validate_input("c4")
        expect(result).to eq(true)
      end
    end
  end

  describe "#convert_input" do
    subject(:input_board) { described_class.new }

    context "when fed algebraic notation ie c6" do

      it "converts it into the appropriate board position" do
        result = input_board.convert_input("c1")
        expect(result).to eq([0,2])
      end
    end
    context "when fed faulty notation ie l3 or c9" do
      it "returns false" do
        wrong_num = input_board.convert_input("c9")
        wrong_let = input_board.convert_input("l3")
        expect(wrong_let).to eq(false)
        expect(wrong_num).to eq(false)
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
end
