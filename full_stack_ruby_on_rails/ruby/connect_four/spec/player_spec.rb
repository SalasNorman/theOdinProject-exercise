require_relative '../lib/player'
require_relative '../lib/board'

RSpec.describe Player do
  let(:board) { Board.new }
  subject(:player) { Player.new('Alice', 'X') }

  before do
    allow(player).to receive(:puts)
  end

  describe '#initialize' do
    it 'stores the name and piece' do
      expect(player.name).to eq('Alice')
      expect(player.piece).to eq('X')
    end
  end

  describe '#make_move' do
    it 're-prompts on non-numeric input and accepts a valid column' do
      # foo -> invalid, 0 -> out of range, 2 -> valid
      input = StringIO.new("foo\n0\n2\n")
      allow(player).to receive(:gets) { input.gets }

      pos = player.make_move(board)
      expect(pos).to eq([Board::ROWS - 1, 1])
    end

    it 're-prompts when the chosen column is full' do
      # fill column 1 completely
      Board::ROWS.times { board.drop_piece(1, 'X') }
      input = StringIO.new("1\n3\n")
      allow(player).to receive(:gets) { input.gets }

      pos = player.make_move(board)
      expect(pos).to eq([Board::ROWS - 1, 2])
    end
  end
end
