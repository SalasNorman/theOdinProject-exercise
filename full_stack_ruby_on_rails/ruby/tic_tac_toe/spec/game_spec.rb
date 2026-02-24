require_relative 'spec_helper'

RSpec.describe Game do
  subject(:game) { described_class.new }

  describe '#check_winner' do
    it 'detects a horizontal win for O' do
      game.board.table = [['O','O','O'],[4,5,6],[7,8,9]]
      expect(game.check_winner('O')).to be true
    end

    it 'detects a vertical win for X' do
      game.board.table = [["X",2,3],["X",5,6],["X",8,9]]
      expect(game.check_winner('X')).to be true
    end

    it 'detects a diagonal win' do
      game.board.table = [["X",2,3],[4,"X",6],[7,8,"X"]]
      expect(game.check_winner('X')).to be true
    end

    it 'returns false when no one has won' do
      expect(game.check_winner('O')).to be false
    end
  end

  describe '#game_over' do
    it 'returns false when the board is not full' do
      expect(game.game_over).to be false
    end

    it 'returns true and prints tie message when board is full' do
      (1..9).each { |i| game.board.update(i, 'O') }
      expect { game.game_over }.to output(/It's a Tie!/).to_stdout
      expect(game.game_over).to be true
    end
  end
end
