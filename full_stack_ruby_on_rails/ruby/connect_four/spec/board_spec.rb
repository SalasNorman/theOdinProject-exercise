require_relative '../lib/board'

RSpec.describe Board do
  # helper for capturing stdout
  def capture_stdout
    old = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = old
  end

  describe '#initialize' do
    it 'creates a table with the expected dimensions and empty cells' do
      board = Board.new
      expect(board.table.size).to eq(Board::ROWS)
      expect(board.table.all? { |r| r.size == Board::COLS }).to be true
      expect(board.table.flatten.all? { |c| c == "." }).to be true
    end
  end

  describe '#drop_piece' do
    let(:board) { Board.new }

    it 'drops a piece into the lowest available row of the given column' do
      position = board.drop_piece(1, 'X')
      expect(position).to eq([Board::ROWS - 1, 0])
      expect(board.table[Board::ROWS - 1][0]).to eq('X')
    end

    it 'returns nil when the column is already full' do
      1.upto(Board::ROWS) { board.drop_piece(3, 'O') }
      expect(board.drop_piece(3, 'X')).to be_nil
    end
  end

  describe '#full?' do
    let(:board) { Board.new }

    it 'is false on a newly created board' do
      expect(board.full?).to be false
    end

    it 'becomes true after every cell has been filled' do
      Board::COLS.times do |col|
        Board::ROWS.times { board.drop_piece(col + 1, 'X') }
      end
      expect(board.full?).to be true
    end
  end

  describe '#display' do
    it 'prints column numbers and the grid to stdout' do
      board = Board.new
      output = capture_stdout { board.display }

      expect(output).to include((1..Board::COLS).to_a.join(' '))
      # there should be one header line and one line per row
      expect(output.lines.count).to eq(Board::ROWS + 1)
    end
  end
end
