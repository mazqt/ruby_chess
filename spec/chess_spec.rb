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

