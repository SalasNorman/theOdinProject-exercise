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

  describe '#play_turn with doubles' do
    it 'queries player, updates board and then asks computer' do
      player_double = double('Player', symbol: 'O', get_move: 1)
      computer_double = double('Computer', symbol: 'X', get_move: 5)
      board_double = double('Board')

      allow(board_double).to receive(:valid_move?).with(1).and_return(true)
      allow(board_double).to receive(:update)
      allow(board_double).to receive(:full?).and_return(false)

      allow(game).to receive(:board).and_return(board_double)
      allow(game).to receive(:player).and_return(player_double)
      allow(game).to receive(:computer).and_return(computer_double)
      allow(game).to receive(:check_winner).and_return(false)

      result = game.play_turn

      expect(board_double).to have_received(:update).with(1, 'O')
      expect(board_double).to have_received(:update).with(5, 'X')
      expect(result).to eq(false)
    end
  end
end
