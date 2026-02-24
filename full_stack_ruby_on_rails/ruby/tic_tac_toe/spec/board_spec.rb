require_relative 'spec_helper'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'sets up a 3x3 board with numbers 1 to 9' do
      expect(board.table).to eq([[1,2,3],[4,5,6],[7,8,9]])
    end
  end

  describe '#valid_move?' do
    it 'returns true for an unoccupied cell' do
      expect(board.valid_move?(1)).to be true
    end

    it 'returns false for an occupied cell' do
      board.update(1, 'O')
      expect(board.valid_move?(1)).to be false
    end
  end

  describe '#update' do
    it 'places the symbol at the given position' do
      board.update(5, 'X')
      expect(board.table[1][1]).to eq('X')
    end
  end

  describe '#full?' do
    it 'is false on a fresh board' do
      expect(board.full?).to be false
    end

    it 'becomes true when all cells are filled' do
      (1..9).each { |i| board.update(i, 'O') }
      expect(board.full?).to be true
    end
  end
end
