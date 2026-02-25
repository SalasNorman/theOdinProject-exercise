require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/checker'
require_relative '../lib/player'
require_relative '../lib/computer'

RSpec.describe Game do
  before do
    # suppress I/O during initialization
    allow_any_instance_of(Game).to receive(:puts)
    allow_any_instance_of(Game).to receive(:gets).and_return("Tester\n")
  end

  describe '#switch_player' do
    it 'alternates between human player and computer' do
      game = Game.new
      human = game.instance_variable_get(:@player)
      computer = game.instance_variable_get(:@computer)

      game.switch_player
      expect(game.instance_variable_get(:@current_player)).to eq(computer)

      game.switch_player
      expect(game.instance_variable_get(:@current_player)).to eq(human)
    end
  end

  describe '#play' do
    let(:game) { Game.new }

    before do
      allow(game).to receive(:puts)
    end

    it 'terminates immediately when current player wins' do
      fake_board = double('board', display: nil, full?: false)
      winner = double('player', name: 'P', piece: 'X', make_move: [0, 0])

      game.instance_variable_set(:@board, fake_board)
      game.instance_variable_set(:@current_player, winner)

      allow(Checker).to receive(:win?).and_return(true)

      expect(game.play).to be_nil
    end

    it 'declares a draw when the board becomes full without a win' do
      fake_board = double('board', display: nil, full?: true)
      mover = double('player', name: 'P', piece: 'X', make_move: [0, 0])

      game.instance_variable_set(:@board, fake_board)
      game.instance_variable_set(:@current_player, mover)

      allow(Checker).to receive(:win?).and_return(false)

      expect(game.play).to be_nil
    end

    it 'switches player if no win or draw yet and continues until win occurs' do
      fake_board = double('board', display: nil, full?: false)
      human = double('player', name: 'H', piece: 'X', make_move: [0, 0])
      comp = double('player', name: 'C', piece: 'O', make_move: [0, 1])

      game.instance_variable_set(:@board, fake_board)
      game.instance_variable_set(:@player, human)
      game.instance_variable_set(:@computer, comp)
      game.instance_variable_set(:@current_player, human)

      # first turn no win, second turn win
      allow(Checker).to receive(:win?).and_return(false, true)
      expect(game).to receive(:switch_player).once

      game.play
    end
  end
end
