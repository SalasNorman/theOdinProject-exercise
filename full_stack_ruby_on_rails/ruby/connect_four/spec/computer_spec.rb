require_relative '../lib/computer'
require_relative '../lib/board'

RSpec.describe Computer do
  let(:board) { Board.new }
  let(:computer) { Computer.new('O') }

  before do
    # silence output and delay
    allow(computer).to receive(:puts)
    allow(computer).to receive(:sleep)
  end

  describe '#initialize' do
    it 'assigns a default name and the given piece' do
      comp = Computer.new('Z')
      expect(comp.name).to eq('Computer')
      expect(comp.piece).to eq('Z')
    end
  end

  describe '#make_move' do
    it 'returns the position returned by drop_piece and uses a valid column' do
      called = nil
      allow(board).to receive(:drop_piece) do |col, piece|
        called = col
        [Board::ROWS - 1, col - 1]
      end

      pos = computer.make_move(board)
      expect(pos).to eq([Board::ROWS - 1, called - 1])
      expect(called).to be_between(1, Board::COLS)
    end

    it 'never attempts to drop into a full column' do
      # mark column 1 as full at the top row
      board.table[0][0] = 'X'
      called_columns = []
      allow(board).to receive(:drop_piece) do |col, piece|
        called_columns << col
        [Board::ROWS - 1, col - 1]
      end

      10.times { computer.make_move(board) }
      expect(called_columns).not_to include(1)
    end
  end
end
