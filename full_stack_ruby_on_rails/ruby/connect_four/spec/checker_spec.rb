require_relative '../lib/board'
require_relative '../lib/checker'

RSpec.describe Checker do
  let(:board) { Board.new }

  describe '.win?' do
    context 'when four pieces are aligned vertically' do
      it 'returns true' do
        col = 2
        # place four in a column starting from bottom
        (Board::ROWS - 1).downto(Board::ROWS - 4) do |r|
          board.table[r][col] = 'X'
        end
        expect(Checker.win?(board, 'X', [Board::ROWS - 4, col])).to be true
      end
    end

    context 'when four pieces are aligned horizontally' do
      it 'returns true' do
        row = Board::ROWS - 1
        (0..3).each { |c| board.table[row][c] = 'O' }
        expect(Checker.win?(board, 'O', [row, 3])).to be true
      end
    end

    context 'when four pieces are aligned in a backslash diagonal' do
      it 'returns true' do
        # start bottom-left and go up-right
        start_row = Board::ROWS - 1
        start_col = 0
        4.times do |i|
          board.table[start_row - i][start_col + i] = 'X'
        end
        expect(Checker.win?(board, 'X', [Board::ROWS - 4, 3])).to be true
      end
    end

    context 'when four pieces are aligned in a slash diagonal' do
      it 'returns true' do
        # start bottom-right and go up-left
        start_row = Board::ROWS - 1
        start_col = 3
        4.times do |i|
          board.table[start_row - i][start_col - i] = 'O'
        end
        expect(Checker.win?(board, 'O', [Board::ROWS - 4, 0])).to be true
      end
    end

    context 'when there is not a winning configuration' do
      it 'returns false' do
        expect(Checker.win?(board, 'X', [0, 0])).to be false
      end
    end
  end
end
