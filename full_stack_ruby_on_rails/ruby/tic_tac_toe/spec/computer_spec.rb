require_relative 'spec_helper'

RSpec.describe Computer do
  subject(:computer) { described_class.new }

  describe '#initialize' do
    it 'has the name Computer and default symbol X' do
      expect(computer.name).to eq('Computer')
      expect(computer.symbol).to eq('X')
    end
  end

  describe '#get_move' do
    it 'returns an integer that corresponds to an empty cell on the board' do
      board = Board.new
      # reserve a couple of cells
      board.update(1, 'O')
      board.update(9, 'X')

      move = computer.get_move(board)
      # move should be one of the remaining integers
      expect(board.table.flatten.select { |v| v.is_a?(Integer) }).to include(move)
      expect(move).to be_a(Integer)
    end
  end
end
